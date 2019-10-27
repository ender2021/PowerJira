#import PowerJira
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \..\PowerJira\PowerJira.psm1) -Force

#import the variable $JiraCredentials
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \credentials\Credentials.psm1) -Force

#open a new Jira session
Open-JiraSession -UserName $JiraCredentials.UserName -Password $JiraCredentials.ApiToken -HostName $JiraCredentials.HostName

#do tests here

#CREATE FILTER
#Invoke-JiraCreateFilter "test filter 8" "project = JPT ORDER BY Summary" -Favourite -Expand @("sharedUsers")

#GET DEFAULT SHARE SCOPE
#Invoke-JiraGetDefaultShareScope

#SET DEFAULT SHARE SCOPE
#Invoke-JiraSetDefaultShareScope "PRIVATE"

#GET FAVOURITE FILTERS
#Invoke-JiraGetFavouriteFilters

#GET MY FILTERS
#Invoke-JiraGetMyFilters -Favourites

#SEARCH FILTERS
#Invoke-JiraSearchFilters "8" -OwnerAccountId (Invoke-JiraGetCurrentUser).accountId

#GET FILTER
#Invoke-JiraGetFilter 10008

#UPDATE FILTER
#Invoke-JiraUpdateFilter 10008 -SharePermissions @((New-JiraFilterSharePermission "authenticated"))
#Invoke-JiraGetProject 10000

#DELETE FILTER
#Invoke-JiraGetFilter 10005
#Invoke-JiraDeleteFilter 10008

#GET FILTER SHARE PERMISSIONS
#Invoke-JiraGetFilterSharePermissions 10004

#GET FILTER SHARE PERMISSION
#Invoke-JiraGetFilterSharePermission 10004 10103

#DELETE FILTER SHARE PERMISSION
#Invoke-JiraDeleteFilterSharePermission 10004 10103

#ADD FILTER SHARE PERMISSION
#Invoke-JiraAddFilterSharePermission 10004 (New-JiraFilterSharePermission "authenticated")

#ADD FAVOURITE FILTER
#Invoke-JiraAddFavouriteFilter 10004

#REMOVE FAVOURITE FILTER
#Invoke-JiraRemoveFavouriteFilter 10004

#GET FILTER COLUMNS
#Invoke-JiraGetFilterColumns 10004

#RESET FILTER COLUMNS
#Invoke-JiraResetFilterColumns 10004

#SET FILTER COLUMNS
#Invoke-JiraSetFilterColumns 10004 @("issuekey","summary")

#end tests

#close the Jira session
Close-JiraSession