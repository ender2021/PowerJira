#import PowerJira
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \..\PowerJira.psm1) -Force

#import the variable $JiraCredentials
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \credentials\Credentials.psm1) -Force

#open a new Jira session
Open-JiraSession -UserName $JiraCredentials.UserName -Password $JiraCredentials.ApiToken -HostName $JiraCredentials.HostName

#do tests here

#CREATE VERSION
#$newVersion = Invoke-JiraCreateVersion -ProjectId $proj.id -Name "Test Version 6" -StartDate (Get-Date "2019-03-18")
#$newVersion

#UPDATE VERSION
#Invoke-JiraUpdateVersion -VersionId 10485 -Archived $false

#GET VERSION
#$test1 = Invoke-JiraGetVersion -VersionId 10484

#DELETE VERSION
#Invoke-JiraDeleteVersion -VersionId 10485

#MOVE VERSION
#Invoke-JiraMoveVersion -VersionId 10484 -Position "First"

#MERGE VERSION
#Invoke-JiraMergeVersion -SourceVersionId 10480 -TargetVersionId 10482

#GET VERSION RELATED ISSUE COUNTS
#Invoke-JiraGetVersionRelatedIssueCounts -VersionId 10482

#GET VERSION UNRESOLVLED ISSUE COUNTS
#Invoke-JiraGetVersionUnresolvedIssueCount -VersionId 10482

#end tests

#close the Jira session
Close-JiraSession