#import PowerJira
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \..\PowerJira.psm1) -Force

#import the variable $JiraCredentials
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \credentials\Credentials.psm1) -Force

#open a new Jira session
Open-JiraSession -UserName $JiraCredentials.UserName -Password $JiraCredentials.ApiToken -HostName $JiraCredentials.HostName

#do tests here

#GET CURRENT USER
#$user = Invoke-JiraGetCurrentUser -ExpandGroups
#$user.groups

#FIND USERS
#Invoke-JiraFindUsers "Mark" 2 1

#end tests

#close the Jira session
Close-JiraSession