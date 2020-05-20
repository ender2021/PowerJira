# PSake makes variables declared here available in other scriptblocks
# Init some things
Properties {
    # Find the build folder based on build system
        $ProjectRoot = $ENV:BHProjectPath
        if(-not $ProjectRoot)
        {
            $ProjectRoot = $PSScriptRoot
        }

    $Timestamp = Get-date -uformat "%Y%m%d-%H%M%S"
    $PSVersion = $PSVersionTable.PSVersion.Major
    $TestFile = "TestResults_PS$PSVersion`_$TimeStamp.xml"
    $lines = '----------------------------------------------------------------------'

    $Verbose = @{}
    if($ENV:BHCommitMessage -match "!verbose")
    {
        $Verbose = @{Verbose = $True}
    }
}

Task Default -Depends Deploy

Task Init {
    $lines
    Set-Location $ProjectRoot
    "Build System Details:"
    Get-Item ENV:BH*
    "`n"

    Update-Module PowerShellGet -RequiredVersion "2.2.4.1"

    $mod = Get-Module PowerShellGet
    "PowerShellGet Version: " + $mod.Version
    "`n"
}

Task Test -Depends Init  {
    $lines
    "`n`tSTATUS: Testing with PowerShell $PSVersion"

    Import-Module $ProjectRoot\PowerJira\PowerJira.psm1
    $privateFiles = Get-ChildItem -Path $ProjectRoot\PowerJira\private -Recurse -Include *.ps1 -ErrorAction SilentlyContinue
    if(@($privateFiles).Count -gt 0) { $privateFiles.FullName | ForEach-Object { . $_ } }

    # Gather test results. Store them in a variable and file
    $TestResults = Invoke-Pester -Path $ProjectRoot\Tests -PassThru -OutputFormat NUnitXml -OutputFile "$ProjectRoot\$TestFile"

    # In Appveyor?  Upload our tests! #Abstract this into a function?
    If($ENV:BHBuildSystem -eq 'AppVeyor')
    {
        (New-Object 'System.Net.WebClient').UploadFile(
            "https://ci.appveyor.com/api/testresults/nunit/$($env:APPVEYOR_JOB_ID)",
            "$ProjectRoot\$TestFile" )
    }

    Remove-Item "$ProjectRoot\$TestFile" -Force -ErrorAction SilentlyContinue

    # Failed tests?
    # Need to tell psake or it will proceed to the deployment. Danger!
    if($TestResults.FailedCount -gt 0)
    {
        Write-Error "Failed '$($TestResults.FailedCount)' tests, build failed"
    }
    "`n"
}

Task Build -Depends Test {
    $lines
    
    # Load the module, read the exported functions, update the psd1 FunctionsToExport
    Set-ModuleFunctions

    # Bump the module version
    Update-Metadata -Path $env:BHPSModuleManifest
}

Task Deploy -Depends Build {
    $lines

    # Publish to gallery with a few restrictions
    if(
        $env:BHPSModulePath -and
        $env:BHBuildSystem -ne 'Unknown' -and
        $env:BHBranchName -eq "master" -and
        $env:BHCommitMessage -match '!deploy'
    )
    {
        $target = "PSGallery"
        $moduleName = $ProjectRoot.Substring($ProjectRoot.LastIndexOf("\") + 1)
        $path = "$ProjectRoot\$moduleName"

        # Validate that $target has been setup as a valid PowerShell repository
        $validRepo = Get-PSRepository -Name $target -Verbose:$false -ErrorAction SilentlyContinue
        if (-not $validRepo) {
            throw "[$target] has not been setup as a valid PowerShell repository."
        }

        $params = @{
            Path       = $path
            Repository = $target
            Verbose    = $true
            NuGetApiKey     = $ENV:NugetApiKey
        }

        Publish-Module @params -SkipAutomaticTags
    }
    else
    {
        "Skipping deployment: To deploy, ensure that...`n" +
        "`t* You are in a known build system (Current: $ENV:BHBuildSystem)`n" +
        "`t* You are committing to the master branch (Current: $ENV:BHBranchName) `n" +
        "`t* Your commit message includes !deploy (Current: $ENV:BHCommitMessage)" |
            Write-Host
    }
}