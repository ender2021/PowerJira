#import PowerJira
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \..\PowerJira\PowerJira.psm1) -Force

#import the variable $JiraCredentials
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \credentials\Credentials.psm1) -Force

#open a new Jira session
$context = Open-JiraSession -UserName $JiraCredentials.UserName -Password $JiraCredentials.ApiToken -HostName $JiraCredentials.HostName

#do tests here

#CREATE VERSION
#Invoke-JiraCreateVersion 10000 -Name "Blargh Version 10" -StartDate (Get-Date "2019-05-18")

#UPDATE VERSION
#Invoke-JiraUpdateVersion -VersionId 10000 -Archived $false

#GET VERSION
#Invoke-JiraGetVersion 10005

#DELETE VERSION
#Invoke-JiraDeleteVersion -VersionId 10003

#MOVE VERSION
#Invoke-JiraMoveVersion -VersionId 10004 -Position "First"

#MERGE VERSION
#Invoke-JiraMergeVersion -SourceVersionId 10004 -TargetVersionId 10005

#GET VERSION RELATED ISSUE COUNTS
#Invoke-JiraGetVersionRelatedIssueCounts -VersionId 10005

#GET VERSION UNRESOLVLED ISSUE COUNTS
#Invoke-JiraGetVersionUnresolvedIssueCount 10000

#end tests

#close the Jira session
Close-JiraSession