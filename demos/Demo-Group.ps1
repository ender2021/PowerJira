#import PowerJira
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \..\PowerJira\PowerJira.psm1) -Force

#import the variable $JiraCredentials
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \credentials\Credentials.psm1) -Force

#open a new Jira session
Open-JiraSession -UserName $JiraCredentials.UserName -Password $JiraCredentials.ApiToken -HostName $JiraCredentials.HostName

#do tests here

#FIND GROUPS
#Invoke-JiraFindGroups test -Exclude @("one","two","three","four")

#FIND USERS AND GROUPS
#$results = Invoke-JiraFindUsersAndGroups ucsb -ShowAvatar
#$results.users.header

#CREATE GROUP
#Invoke-JiraCreateGroup "perm-test-group-1"

#DELETE GROUP
# $groupname = "group-to-be-deleted"
# Invoke-JiraCreateGroup $groupname
# Read-Host -Prompt "Press any key to continue or CTRL+C to quit"
# Invoke-JiraDeleteGroup $groupname

#ADD USER TO GROUP
#Invoke-JiraAddUserToGroup "perm-test-group-1" (Invoke-JiraGetCurrentUser).accountId

#GET GROUP USERS
#Invoke-JiraGetGroupUsers "perm-test-group-1" 0 10

#REMOVE USER FROM GROUP
#Invoke-JiraRemoveUserFromGroup "perm-test-group-1" (Invoke-JiraGetCurrentUser).accountId

#end tests

#close the Jira session
Close-JiraSession