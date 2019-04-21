#import PowerJira
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \..\PowerJira\PowerJira.psm1) -Force

#import the variable $JiraCredentials
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \credentials\Credentials.psm1) -Force

#open a new Jira session
Open-JiraSession -UserName $JiraCredentials.UserName -Password $JiraCredentials.ApiToken -HostName $JiraCredentials.HostName

#do tests here

#GET ALL PERMISSIONS SCHEMES
#Invoke-JiraGetAllPermissionSchemes

#GET PERMISSION SCHEME
#Invoke-JiraGetPermissionScheme 0

#CREATE PERMISSION SCHEME
#Invoke-JiraCreatePermissionScheme "scheme with no details"
# $permissions = @(
#     New-JiraPermissionGrant (New-JiraPermissionHolder "projectLead") "ADD_COMMENTS"
# )
# Invoke-JiraCreatePermissionScheme "scheme with a permission" -Permissions $permissions

#DELETE PERMISSION SCHEME
#Invoke-JiraDeletePermissionScheme 10001

#UPDATE PERMISSION SCHEME
#Invoke-JiraUpdatePermissionScheme 10002 "removed permissions" -Permissions @()

#GET PERMISSION SCHEME GRANTS
#Invoke-JiraGetPermissionSchemeGrants 10000

#end tests

#close the Jira session
Close-JiraSession