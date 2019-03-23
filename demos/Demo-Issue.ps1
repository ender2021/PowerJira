#import PowerJira
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \..\PowerJira.psm1) -Force

#import the variable $JiraCredentials
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \credentials\Credentials.psm1) -Force

#open a new Jira session
Open-JiraSession -UserName $JiraCredentials.UserName -Password $JiraCredentials.ApiToken -HostName $JiraCredentials.HostName

#do tests here

#GET CREATE ISSUE METADATA
#$meta = Invoke-JiraGetIssueCreateMetadata -ProjectKeys @("JPT") -ExpandFields
#$meta.projects[0].issuetypes[0].fields

#GET ISSUE
#Invoke-JiraGetIssue GROPGDIS-749 -ExpandOperations

#CREATE ISSUE
# $createFields = @{
#   issuetype = @{id=10001} #task
#   summary = "PJ Test Issue 1"
#   project = @{id=13324}
#   reporter = @{id=(Invoke-JiraGetCurrentUser).accountId}
# }

# Invoke-JiraCreateIssue -Fields $createFields

#UPDATE ISSUE
# $updateFields = @{
#   issuetype = @{id=10001} #task
#   summary = "PJ Test Issue 1"
#   project = @{id=13324}
#   reporter = @{id=(Invoke-JiraGetCurrentUser).accountId}
# }

#Invoke-JiraEditIssue JPT-1 $updateFields

#GET EDIT ISSUE METADATA
#(Invoke-JiraGetIssueEditMetadata JPT-1).fields

#TRANSITION ISSUE
#Invoke-JiraTransitionIssue JPT-1 71

#ASSIGN ISSUE
#Invoke-JiraAssignIssue JPT-1 -AssigneeAccountId (Invoke-JiraGetCurrentUser).accountId
#Invoke-JiraAssignIssue JPT-1 -Unassign
#Invoke-JiraAssignIssue JPT-1 -ProjectDefault

#ADD COMMENT
#Invoke-JiraAddComment JPT-1 "This is another comment from Powershell!"

#ADD WORKLOG
#Invoke-JiraAddWorklog JPT-1 "2h" "Time formats are a real bastard"

#ADD WATCHER
#Invoke-JiraAddWatcher JPT-1 "557058:6af86a88-d849-4258-b7e7-0d310a2eb87e" #josh

#GET ISSUE WATCHERS
#(Invoke-JiraGetIssueWatchers JPT-1).watchers

#GET ISSUE TRANSITIONS
#(Invoke-JiraGetIssueTransitions JPT-1).TRANSITIONS

#end tests

#close the Jira session
Close-JiraSession