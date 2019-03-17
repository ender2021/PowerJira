#import PowerJira
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \..\PowerJira.psm1) -Force

#import the variable $JiraCredentials
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \Credentials.psm1) -Force

#open a new Jira session
Open-JiraSession -UserName $JiraCredentials.UserName -Password $JiraCredentials.ApiToken -HostName $JiraCredentials.HostName

#$proj = Invoke-JiraGetProject "JPT" @("projectKeys")
#$proj
#$newVersion = Invoke-JiraCreateVersion -ProjectId $proj.id -Name "Test Version 6" -StartDate (Get-Date "2019-03-18")
#$newVersion

#Invoke-JiraGetProjectVersions -ProjectIdOrKey "GROPGDIS" -Expand @("operations")
Invoke-JiraUpdateVersion -VersionId 10485 -Archived $false
#$test1 = Invoke-JiraGetVersion -VersionId 10480
#Invoke-JiraMoveVersion -VersionId 10482 -After $test1.self
#Invoke-JiraMergeVersion -SourceVersionId 10480 -TargetVersionId 10482
#Invoke-JiraGetVersionRelatedIssueCounts -VersionId 10482
#Invoke-JiraGetVersionUnresolvedIssueCount -VersionId
#$results = Invoke-JiraSearchIssues -JQL "project = GROPGDIS" -MaxResults 10
#$results.issues
#Invoke-JiraGetIssue -IssueKey GROPGDIS-749



#close the Jira session
Close-JiraSession