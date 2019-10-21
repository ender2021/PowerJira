Using Module ..\PowerJira\PowerJira.psm1

#import the variable $JiraCredentials
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \credentials\Credentials.psm1) -Force

#open a new Jira session
$context = [JiraContext]::new($JiraCredentials.UserName,$JiraCredentials.ApiToken,$JiraCredentials.HostName)
$context.OpenSession()

#do tests here

#GET ALL PROJECT CATEGORIES
Invoke-JiraGetAllProjectCategories

#CREATE PROJECT CATEGORY
#Invoke-JiraCreateProjectCategory "new category" "this is a description"

#GET PROJECT CATEGORY
#Invoke-JiraGetProjectCategory 10000

#UPDATE PROJECT CATEGORY
#Invoke-JiraUpdateProjectCategory 10000 "name change"

#DELETE PROJECT CATEGORY
#Invoke-JiraDeleteProjectCategory 10000

#end tests

#close the Jira session
$context.CloseSession()