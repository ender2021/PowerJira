#import PowerJira
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \..\PowerJira.psm1) -Force

#import the variable $JiraCredentials
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \Credentials.psm1) -Force

#open a new Jira session
Open-JiraSession -UserName $JiraCredentials.UserName -ApiToken $JiraCredentials.ApiToken -HostName $JiraCredentials.HostName

$versions = Invoke-JiraGetProjectVersions -ProjectKey GROPGDIS
$versions

#close the Jira session
Close-JiraSession