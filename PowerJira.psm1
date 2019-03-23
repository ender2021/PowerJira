$modulesFolder = "$PSScriptRoot\modules\api-v2"
foreach ($module in Get-Childitem $modulesFolder -Name -Filter "*.psm1")
{
    Import-Module $modulesFolder\$module -Force
}

Export-ModuleMember -Function * -Variable *