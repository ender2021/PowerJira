#import PowerJira
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \..\PowerJira\PowerJira.psm1) -Force

#import the variable $JiraCredentials
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \credentials\Credentials.psm1) -Force

#open a new Jira session
Open-JiraSession -UserName $JiraCredentials.UserName -Password $JiraCredentials.ApiToken -HostName $JiraCredentials.HostName

#do tests here

#CREATE VERSION
#Invoke-JiraCreateVersion 10000 -Name "Blargh Version 8" -StartDate (Get-Date "2019-05-18")

#UPDATE VERSION
#Invoke-JiraUpdateVersion -VersionId 10485 -Archived $false

#GET VERSION
#Invoke-JiraGetVersion 10000

#DELETE VERSION
#Invoke-JiraDeleteVersion -VersionId 10485

#MOVE VERSION
#Invoke-JiraMoveVersion -VersionId 10484 -Position "First"

#MERGE VERSION
#Invoke-JiraMergeVersion -SourceVersionId 10480 -TargetVersionId 10482

#GET VERSION RELATED ISSUE COUNTS
#Invoke-JiraGetVersionRelatedIssueCounts -VersionId 10482

#GET VERSION UNRESOLVLED ISSUE COUNTS
#Invoke-JiraGetVersionUnresolvedIssueCount 10000

#end tests

#close the Jira session
Close-JiraSession