#import PowerJira
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \..\PowerJira\PowerJira.psm1) -Force

#import the variable $JiraCredentials
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \credentials\Credentials.psm1) -Force

#open a new Jira session
Open-JiraSession -UserName $JiraCredentials.UserName -Password $JiraCredentials.ApiToken -HostName $JiraCredentials.HostName

#do tests here

#GET ALL STATUSES
#Invoke-JiraGetAllStatuses

#GET STATUS
#Invoke-JiraGetStatus 10001

#GET ALL STATUS CATEGORIES
#Invoke-JiraGetAllStatusCategories

#GET STATUS CATEGORY
#Invoke-JiraGetStatusCategory 2

#end tests

#close the Jira session
Close-JiraSession