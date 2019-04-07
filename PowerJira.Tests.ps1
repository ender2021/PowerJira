Import-Module $PSScriptRoot\PowerJira\PowerJira.psm1 -Force

# grab private functions from files
$privateFiles = Get-ChildItem -Path $PSScriptRoot\..\PowerJira\private -Recurse -Include *.ps1 -ErrorAction SilentlyContinue
if(@($privateFiles).Count -gt 0) { $privateFiles.FullName | ForEach-Object { . $_ } }

Invoke-Pester $PSScriptRoot\tests -Show Failed, Summary