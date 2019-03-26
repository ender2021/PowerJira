#import PowerJira
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \..\PowerJira.psm1) -Force

#import the variable $JiraCredentials
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \credentials\Credentials.psm1) -Force

#open a new Jira session
Open-JiraSession -UserName $JiraCredentials.UserName -Password $JiraCredentials.ApiToken -HostName $JiraCredentials.HostName

#do tests here

#FIND GROUPS
#Invoke-JiraFindGroups sist @("graddiv-sist-oversight-committee") 1

#FIND USERS AND GROUPS
#$results = Invoke-JiraFindUsersAndGroups ucsb -ShowAvatar
#$results.users.header

#CREATE GROUP
#Invoke-JiraCreateGroup "test-group-123"

#DELETE GROUP
# $groupname = "group-to-be-deleted"
# Invoke-JiraCreateGroup $groupname
# Read-Host -Prompt "Press any key to continue or CTRL+C to quit"
# Invoke-JiraDeleteGroup $groupname

#end tests

#close the Jira session
Close-JiraSession