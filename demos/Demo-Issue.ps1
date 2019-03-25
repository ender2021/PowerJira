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

#ADD WATCHER
#Invoke-JiraAddWatcher JPT-1 

#GET ISSUE WATCHERS
#(Invoke-JiraGetIssueWatchers JPT-1).watchers

#GET ISSUE TRANSITIONS
#(Invoke-JiraGetIssueTransitions JPT-1).TRANSITIONS

#BULK ISSUE CREATE
# $issues = @()
# for ($i=1;$i -lt 4;$i++) {
#     $issues += @{
#         fields = @{
#             issuetype = @{id=10001} #task
#             summary = "PJ Test Issue Bulk Create $i"
#             project = @{id=13324}
#             reporter = @{id=(Invoke-JiraGetCurrentUser).accountId}
#         }
#     }
# }
# Invoke-JiraCreateIssueBulk $issues

#ADD ATTACHMENT
# $txt = Get-Item -Path (Join-Path -Path $PSScriptRoot -ChildPath \SampleAttachment1.txt)
# $png = Get-Item -Path (Join-Path -Path $PSScriptRoot -ChildPath \SampleAttachment2.png)
# Invoke-JiraAddAttachment JPT-1 $txt
# Invoke-JiraAddAttachment JPT-1 $png

#DELETE WATCHER
# $josh = (Invoke-JiraFindUsers Josh)[0].accountId
# Invoke-JiraAddWatcher JPT-1 $josh
# Read-Host -Prompt "Press any key to continue or CTRL+C to quit"
# Invoke-JiraDeleteWatcher JPT-1 $josh

#GET VOTES
#Invoke-JiraGetVotes JPT-1

#ADD VOTE
#Invoke-JiraAddVote JPT-1
#Invoke-JiraGetVotes JPT-1

#DELETE VOTE
# Clear-Host
# Invoke-JiraGetVotes JPT-1
# Invoke-JiraAddVote JPT-1
# Invoke-JiraGetVotes JPT-1
# Invoke-JiraDeleteVote JPT-1
# Invoke-JiraGetVotes JPT-1

#SEND ISSUE NOTIFICATION
# $me = Invoke-JiraGetCurrentUser
# Invoke-JiraSendIssueNotification JPT-1 "This is a test message, let me know if you get it -Justin"

#end tests

#close the Jira session
Close-JiraSession