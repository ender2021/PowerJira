#import PowerJira
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \..\PowerJira\PowerJira.psm1) -Force

#import the variable $JiraCredentials
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \credentials\Credentials.psm1) -Force

#open a new Jira session
Open-JiraSession -UserName $JiraCredentials.UserName -Password $JiraCredentials.ApiToken -HostName $JiraCredentials.HostName

#do tests here

#GET CURRENT USER
#$user = Invoke-JiraGetCurrentUser
#$user

#FIND USERS
#Invoke-JiraFindUsers "Mike"

#GET USER
#$users = Invoke-JiraFindUsers "Steven"
#(Invoke-JiraGetUser $users[0].accountId).applicationRoles

#GET USER GROUPS
#$users = Invoke-JiraFindUsers "Melanie"
#Invoke-JiraGetUserGroups $users[0].accountId

#GET CURRENT USER PERMISSIONS
#Invoke-JiraGetCurrentUserPermissions @("WORK_ON_ISSUES","VIEW_VOTERS_AND_WATCHERS") | fl

#end tests

#close the Jira session
Close-JiraSession