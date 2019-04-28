#import PowerJira
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \..\PowerJira\PowerJira.psm1) -Force

#import the variable $JiraCredentials
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \credentials\Credentials.psm1) -Force

#open a new Jira session
Open-JiraSession -UserName $JiraCredentials.UserName -Password $JiraCredentials.ApiToken -HostName $JiraCredentials.HostName

#do tests here

#GET ALL SCREENS
#(Invoke-JiraGetAllScreens).values[0]

#ADD FIELD TO DEFAULT SCREEN
#Invoke-JiraAddDefaultScreenField customfield_10003

#GET AVAILABLE SCREEN FIELDS
#Invoke-JiraGetAvailableScreenFields 2

#GET ALL SCREEN TABS
#Invoke-JiraGetAllScreenTabs 2

#CREATE SCREEN TAB
#Invoke-JiraCreateScreenTab 1 "tabName"

#UPDATE SCREEN TAB
#Invoke-JiraUpdateScreenTab 1 10106 "newTabName"

#DELETE SCREEN TAB
#Invoke-JiraDeleteScreenTab 1 10106

#GET ALL SCREEN TAB FIELDS
#Invoke-JiraGetAllScreenTabFields 1 10000

#ADD SCREEN TAB FIELD
#Invoke-JiraAddScreenTabField 2 10001 versions

#REMOVE SCREEN TAB FIELD
#Invoke-JiraRemoveScreenTabField 2 10001 versions

#REORDER SCREEN TAB
#Invoke-JiraReorderScreenTab 1 10107 1

#end tests

#close the Jira session
Close-JiraSession