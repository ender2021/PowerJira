using module .\classes\JiraDateTime.psm1
using module .\classes\JiraContext.psm1
using module .\classes\PowerJiraGlobal.psm1
using module .\classes\RestMethod\RestQueryKvp.psm1
using module .\classes\RestMethod\RestMethodQueryParams.psm1
using module .\classes\RestMethod\RestMethodBody.psm1
using module .\classes\RestMethod\RestMethodJsonBody.psm1
using module .\classes\RestMethod\RestMethod.psm1
using module .\classes\RestMethod\BodyRestMethod.psm1
using module .\classes\RestMethod\FileRestMethod.psm1
using module .\classes\RestMethod\FormRestMethod.psm1

# grab classes and functions from files
$privateFiles = Get-ChildItem -Path $PSScriptRoot\private -Recurse -Include *.ps1 -ErrorAction SilentlyContinue
$publicFiles = Get-ChildItem -Path $PSScriptRoot\public -Recurse -Include *.ps1 -ErrorAction SilentlyContinue

if(@($privateFiles).Count -gt 0) { $privateFiles.FullName | ForEach-Object { . $_ } }
if(@($publicFiles).Count -gt 0) { $publicFiles.FullName | ForEach-Object { . $_ } }

Export-ModuleMember -Function $publicFiles.BaseName

if($null -eq $global:PowerJira) {
	$global:PowerJira = [PowerJiraGlobal]::new()
}

$onRemove = {
	if ($global:PowerJira) {
		Remove-Variable -Name PowerJira -Scope global
	}
}

$ExecutionContext.SessionState.Module.OnRemove += $onRemove
Register-EngineEvent -SourceIdentifier ([System.Management.Automation.PsEngineEvent]::Exiting) -Action $onRemove