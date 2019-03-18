#import PowerJira
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \..\PowerJira.psm1) -Force

#import the variable $JiraCredentials
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \Credentials.psm1) -Force

#open a new Jira session
Open-JiraSession -UserName $JiraCredentials.UserName -Password $JiraCredentials.ApiToken -HostName $JiraCredentials.HostName

#$proj = Invoke-JiraGetProject "JPT" @("projectKeys")
#$proj

#$meta = Invoke-JiraGetIssueCreateMetadata -ProjectKeys @("JPT") -ExpandFields
#$meta.projects[0].issuetypes[0].fields

#$newVersion = Invoke-JiraCreateVersion -ProjectId $proj.id -Name "Test Version 6" -StartDate (Get-Date "2019-03-18")
#$newVersion

#Invoke-JiraGetProjectVersions -ProjectIdOrKey "JPT" -Expand @("operations")
#Invoke-JiraUpdateVersion -VersionId 10485 -Archived $false
#$test1 = Invoke-JiraGetVersion -VersionId 10484
#Invoke-JiraDeleteVersion -VersionId 10485
#Invoke-JiraMoveVersion -VersionId 10484 -Position "First"
#Invoke-JiraMergeVersion -SourceVersionId 10480 -TargetVersionId 10482
#Invoke-JiraGetVersionRelatedIssueCounts -VersionId 10482
#Invoke-JiraGetVersionUnresolvedIssueCount -VersionId 10482
#$results = Invoke-JiraSearchIssues -JQL "project = GROPGDIS" -MaxResults 10
#$results.issues
#Invoke-JiraGetIssue GROPGDIS-749

# $fields = @{
#   issuetype = @{id=10001} #task
#   summary = "PJ Test Issue 1"
#   project = @{id=13324}
# }

# Invoke-JiraCreateIssue -Fields $fields

$user = Invoke-JiraGetCurrentUser -ExpandGroups
$user.groups

#close the Jira session
Close-JiraSession