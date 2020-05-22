#import PowerJira
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \..\PowerJira\PowerJira.psm1) -Force

#import the variable $JiraCredentials
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \credentials\Credentials.psm1) -Force

#open a new Jira session
$context = Open-JiraSession -UserName $JiraCredentials.UserName -Password $JiraCredentials.ApiToken -HostName $JiraCredentials.HostName

#do tests here

#GET ALL PROJECT CATEGORIES
#Invoke-JiraGetAllProjectCategories

#CREATE PROJECT CATEGORY
#Invoke-JiraCreateProjectCategory "new category" "this is a description"

#GET PROJECT CATEGORY
#Invoke-JiraGetProjectCategory 10001

#UPDATE PROJECT CATEGORY
#Invoke-JiraUpdateProjectCategory 10001 "name change"

#DELETE PROJECT CATEGORY
#Invoke-JiraDeleteProjectCategory 10001

#end tests

#close the Jira session
Close-JiraSession