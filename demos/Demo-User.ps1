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

#GET CURRENT USER PREFERENCE
#Invoke-JiraGetCurrentUserPreference "user.madeup.json"

#RESET CURRENT USER PREFERENCE
#Invoke-JiraResetCurrentUserPreference "user.notifications.mimetype"

#SET CURRENT USER PREFERENCE
#Invoke-JiraSetCurrentUserPreference "user.madeup.json" @{attr="someValue";now=(Get-Date)}

#GET CURRENT USER LOCALE
#Invoke-JiraGetCurrentUserLocale

#RESET CURRENT USER LOCALE
#Invoke-JiraResetCurrentUserLocale

#SET CURRENT USER LOCALE
#Invoke-JiraSetCurrentUserLocale "fr_FR"

#GET USER PROPERTY KEYS
#Invoke-JiraGetUserPropertyKeys (Invoke-JiraGetCurrentUser).accountId

#GET USER PROPERTY
#Invoke-JiraGetUserProperty (Invoke-JiraGetCurrentUser).accountId "myProp"

#SET USER PROPERTY
#Invoke-JiraSetUserProperty (Invoke-JiraGetCurrentUser).accountId "myProp" @{hasValue=$true}

#DELETE USER PROPERTY
#Invoke-JiraDeleteUserProperty (Invoke-JiraGetCurrentUser).accountId "myProp"

#GET USER DEFAULT COLUMNS
#Invoke-JiraGetUserDefaultColumns

#SET USER DEFAULT COLUMNS
#Invoke-JiraSetUserDefaultColumns @("issuekey","summary")

#RESET USER DEFAULT COLUMNS
#Invoke-JiraResetUserDefaultColumns

#GET USERS ASSIGNABLE TO PROJECTS
#Invoke-JiraGetUsersAssignableToProjects @("JPT")

#GET USERS ASSIGNABLE TO ISSUES
#Invoke-JiraGetUsersAssignableToIssues -IssueKey "JPT-1"

#end tests

#close the Jira session
Close-JiraSession