#import PowerJira
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \..\PowerJira\PowerJira.psm1) -Force

#import the variable $JiraCredentials
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \credentials\Credentials.psm1) -Force

#open a new Jira session
Open-JiraSession -UserName $JiraCredentials.UserName -Password $JiraCredentials.ApiToken -HostName $JiraCredentials.HostName

#do tests here

#GET ALL PROJECT ROLES
#Invoke-JiraGetAllProjectRoles | Format-List

#CREATE PROJECT ROLE
#Invoke-JiraCreateProjectRole "new-test-role"
#Invoke-JiraCreateProjectRole "new-test-role-2" "This one has a description!"

#UPDATE PROJECT ROLE (PARTIAL)
#Invoke-JiraUpdateProjectRolePartial 10101 -Description "a new description"

#UPDATE PROJECT ROLE (FULL)
#Invoke-JiraUpdateProjectRoleFull 10101 "new-test-role-2" "This one has a description!"


#end tests

#close the Jira session
Close-JiraSession