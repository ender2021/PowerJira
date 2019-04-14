#import PowerJira
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \..\PowerJira\PowerJira.psm1) -Force

#import the variable $JiraCredentials
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \credentials\Credentials.psm1) -Force

#open a new Jira session
Open-JiraSession -UserName $JiraCredentials.UserName -Password $JiraCredentials.ApiToken -HostName $JiraCredentials.HostName

#do tests here

#GET ISSUE TYPE
#Invoke-JiraGetIssueType 10000

#GET ALTERNATIVE ISSUES TYPES
#Invoke-JiraGetAlternativeIssueTypes 10000

#ADD ISSUE TYPE AVATAR
#$item = get-item $PSScriptRoot\icon.png
#Invoke-JiraAddIssueTypeAvatar 10000 $item

#UPDATE ISSUE TYPE
#Invoke-JiraUpdateIssueType 10000 -AvatarId 10512

#CREATE ISSUE TYPE
#Invoke-JiraCreateIssueType "REST Method" "Issues representing REST methods"
#Invoke-JiraCreateIssueType "REST Method Sub-task" "Sub-task of issues representing REST methods" -Subtask

#DELETE ISSUE TYPE
#Invoke-JiraDeleteIssueType 10006

#SET ISSUE TYPE PROPERTY
#Invoke-JiraSetIssueTypeProperty 10005 "propKey" @{name="neato";description="Super cool!"}

#end tests

#close the Jira session
Close-JiraSession