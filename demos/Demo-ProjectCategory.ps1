#import PowerJira
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \..\PowerJira\PowerJira.psm1) -Force

#import the variable $JiraCredentials
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \credentials\Credentials.psm1) -Force

#open a new Jira session
Open-JiraSession -UserName $JiraCredentials.UserName -Password $JiraCredentials.ApiToken -HostName $JiraCredentials.HostName

#do tests here

#GET ALL PROJECT CATEGORIES
#Invoke-JiraGetAllProjectCategories

#CREATE PROJECT CATEGORY
#Invoke-JiraCreateProjectCategory "new category" "this is a description"

#GET PROJECT CATEGORY
#Invoke-JiraGetProjectCategory 10000

#UPDATE PROJECT CATEGORY
#Invoke-JiraUpdateProjectCategory 10000 "name change"

#end tests

#close the Jira session
Close-JiraSession