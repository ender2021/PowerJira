#import PowerJira
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \..\PowerJira.psm1) -Force

#import the variable $JiraCredentials
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \Credentials.psm1) -Force

#open a new Jira session
Open-JiraSession -UserName $JiraCredentials.UserName -ApiToken $JiraCredentials.ApiToken -HostName $JiraCredentials.HostName

# $proj = Invoke-JiraGetProject -ProjectKey "JPT"
# $newVersion = Invoke-JiraCreateVersion -ProjectId $proj.id -Name "Test Version"
# $newVersion

Invoke-JiraUpdateVersion -VersionId 10480 -Description "Successful update!" -StartDate (Get-Date -Format "o")

#close the Jira session
Close-JiraSession