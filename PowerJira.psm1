Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \modules\PJ-Api.psm1) -Force
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \modules\PJ-Version.psm1) -Force

Export-ModuleMember -Function * -Variable *