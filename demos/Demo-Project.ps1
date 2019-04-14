#import PowerJira
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \..\PowerJira\PowerJira.psm1) -Force

#import the variable $JiraCredentials
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \credentials\Credentials.psm1) -Force

#open a new Jira session
Open-JiraSession -UserName $JiraCredentials.UserName -Password $JiraCredentials.ApiToken -HostName $JiraCredentials.HostName

#do tests here

#GET PROJECT
#Invoke-JiraGetProject JPT

#GET PROJECT VERSIONS
#Invoke-JiraGetProjectVersions -ProjectIdOrKey "JPT"

#GET PROJECT VERSIONS PAGINATED
#(Invoke-JiraGetProjectVersionsPaginated JPT -Expand @()).values

#GET PROJECTS
#(Invoke-JiraGetProjects -Expand @("lead")).values

#GET PROJECT COMPONENTS
#Invoke-JiraGetProjectComponents JPT

#GET PROJECTS PAGINATED
#Invoke-JiraGetProjectComponentsPaginated JPT "l;kj;ljk"

#GET PROJECT ROLES FOR PROJECT
#Invoke-JiraGetProjectRolesForProject JPT | format-list

#GET PROJECT ROLE FOR PROJECT
#Invoke-JiraGetProjectRoleForProject JPT 10002 | format-list

#GET PROJECT ROLE DETAILS
#Invoke-JiraGetProjectRoleDetails JPT | Format-List

#ADD ACTORS TO PROJECT ROLE
#Invoke-JiraAddActorsToProjectRole JPT 10002 -Groups @("administrators")
#(Invoke-JiraGetProjectRoleForProject JPT 10002)[0].actors

#SET ACTORS TO PROJECT ROLE
#(Invoke-JiraGetProjectRoleForProject JPT 10002)[0].actors
#Invoke-JiraSetActorsForProjectRole JPT 10002  @((Invoke-JiraGetCurrentUser).accountId)
#(Invoke-JiraGetProjectRoleForProject JPT 10002)[0].actors

#DELETE ACTOR FROM PROJECT ROLE
#Invoke-JiraDeleteActorFromProjectRole JPT 10002  (Invoke-JiraGetCurrentUser).accountId
#(Invoke-JiraGetProjectRoleForProject JPT 10002)[0].actors

#GET ALL PROJECT TYPES
#Invoke-JiraGetAllProjectTypes

#GET PROJECT TYPE BY KEY
#Invoke-JiraGetProjectTypeByKey "software" -Accessible

#GET PROJECT PROPERTY KEYS
#Invoke-JiraGetProjectPropertyKeys JPT | fl

#SET PROJECT PROPERTY
#Invoke-JiraSetProjectProperty JPT "newKey" @{monkey="butt"}

#GET PROJECT PROPERTY
#Invoke-JiraGetProjectProperty JPT "newKey"

#DELETE PROJECT PROPERTY
#Invoke-JiraDeleteProjectProperty JPT "newKey"

#GET ALL PROJECT STATUSES
#Invoke-JiraGetAllProjectStatuses JPT

#GET PROJECT ISSUE SECURITY SCHEME
#Invoke-JiraGetProjectIssueSecurityScheme JPT

#GET PROJECT NOTIFICATION SCHEME
#Invoke-JiraGetProjectNotificationScheme JPT | fl

#GET PROJECT PERMISSION SCHEME
#Invoke-JiraGetProjectPermissionScheme JPT @("permissions") | fl

#GET PROJECT ISSUE SECURITY LEVELS
#Invoke-JiraGetProjectIssueSecurityLevels JPT

#GET VALID PROJECT NAME
#Invoke-JiraGetValidProjectName "PowerJira Testing"

#GET VALID PROJECT KEY
#Invoke-JiraGetValidProjectKey "JPT"

#VALIDATE PROJECT KEY
#Invoke-JiraValidateProjectKey "JPT1"

#GET ALL PROJECT AVATARS
#(Invoke-JiraGetAllProjectAvatars JPT) | fl

#ADD PROJECT AVATAR
#$item = Get-Item $PSScriptRoot\icon.png
#Invoke-JiraAddProjectAvatar JPT $item

#SET PROJECT AVATAR
#Invoke-JiraSetProjectAvatar JPT 10425

#DELETE PROJECT AVATAR
#Invoke-JiraDeleteProjectAvatar JPT 10513

#CREATE PROJECT
#Invoke-JiraCreateProject "RCP" "REST-Created Project" "software" "com.pyxis.greenhopper.jira:gh-simplified-basic" (Invoke-JiraGetCurrentUser).accountId

#DELETE PROJECT
#Invoke-JiraDeleteProject RCP

#UPDATE PROJECT
#Invoke-JiraCreateProject "RCP" "REST-Created Project" "software" "com.pyxis.greenhopper.jira:gh-simplified-basic" (Invoke-JiraGetCurrentUser).accountId
#Invoke-JiraUpdateProject "RCP" -Name "REST-Updated Project"


#end tests

#close the Jira session
Close-JiraSession