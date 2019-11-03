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
#Invoke-JiraCreateProjectRole "new-test-role-delete-swap-2"
#Invoke-JiraCreateProjectRole "new-test-role-2" "This one has a description!"

#UPDATE PROJECT ROLE (PARTIAL)
#Invoke-JiraUpdateProjectRolePartial 10103 -Description "a new description"

#UPDATE PROJECT ROLE (FULL)
#Invoke-JiraUpdateProjectRoleFull 10103 "new-test-role-42" "This one has a description!"

#GET PROJECT ROLE
#Invoke-JiraGetProjectRole 10103

#DELETE PROJECT ROLE
#Invoke-JiraDeleteProjectRole 10103

#GET PROJECT ROLE DEFAULT ACTORS
#Invoke-JiraGetProjectRoleDefaultActors 10002

#ADD PROJECT ROLE DEFAULT ACTORS
#Invoke-JiraAddDefaultActorsToProjectRole 10002 @((Invoke-JiraGetCurrentUser).accountId)
#Invoke-JiraAddDefaultActorsToProjectRole 10002 -Groups @("jira-administrators")

#DELETE PROJECT ROLE DEFAULT ACTOR
#Invoke-JiraGetProjectRoleDefaultActors 10002
#Invoke-JiraDeleteDefaultActorFromProjectRole 10002 (Invoke-JiraGetCurrentUser).accountId
#Invoke-JiraGetProjectRoleDefaultActors 10002


#end tests

#close the Jira session
Close-JiraSession