function Resolve-Module
{
    [Cmdletbinding()]
    param
    (
        [Parameter(Mandatory)]
        [string[]]$Name,

        # Key/value pairs of module names and required versions
        [Parameter()]
        [hashtable]
        $RequiredVersions
    )

    Process
    {
        foreach ($ModuleName in $Name)
        {
            $Module = Get-Module -Name $ModuleName -ListAvailable
            Write-Verbose -Message "Resolving Module $($ModuleName)"
            
            if ($Module) 
            {                
                $Version = $Module | Measure-Object -Property Version -Maximum | Select-Object -ExpandProperty Maximum
                $GalleryVersion = Find-Module -Name $ModuleName -Repository PSGallery | Measure-Object -Property Version -Maximum | Select-Object -ExpandProperty Maximum
                
                if ($Version -lt $GalleryVersion -or ($RequiredVersions.ContainsKey($ModuleName) -and $RequiredVersions[$ModuleName] -ne $Version))
                {
                    $expectedVersion = if ($RequiredVersions.ContainsKey($ModuleName)) {
                        $RequiredVersions[$ModuleName]
                    } else {
                        $GalleryVersion
                    }
                    
                    if ((Get-PSRepository -Name PSGallery).InstallationPolicy -ne 'Trusted') { Set-PSRepository -Name PSGallery -InstallationPolicy Trusted }
                    
                    Write-Verbose -Message "$($ModuleName) Installed Version [$($Version.tostring())] is outdated or does not match required version. Installing Version [$($expectedVersion.tostring())]"
                    
                    Install-Module -Name $ModuleName -Force -RequiredVersion $expectedVersion
                    Import-Module -Name $ModuleName -Force -RequiredVersion $expectedVersion
                }
                else
                {
                    Write-Verbose -Message "Module Installed, Importing $($ModuleName)"
                    Import-Module -Name $ModuleName -Force -RequiredVersion $Version
                }
            }
            else
            {
                Write-Verbose -Message "$($ModuleName) Missing, installing Module"
                $ModuleParams = @{
                    Name = $ModuleName
                    Force = $true
                }
                if ($RequiredVersions.ContainsKey($ModuleName)) {
                    $ModuleParams.Add("RequiredVersion", $RequiredVersions[$ModuleName])
                }
                Install-Module @ModuleParams
                Import-Module @ModuleParams
            }
        }
    }
}

# Grab nuget bits, install modules, set build variables, start build.
Get-PackageProvider -Name NuGet -ForceBootstrap | Out-Null

Resolve-Module -Name Psake, PSDeploy, Pester, BuildHelpers, PowerAtlassianCore -RequiredVersions @{Pester="4.9.0"}

Set-BuildEnvironment

Invoke-psake .\psake.ps1

$host.SetShouldExit([int]( -not $psake.build_success ))