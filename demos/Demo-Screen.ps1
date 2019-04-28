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
#Invoke-JiraAddFieldToDefaultScreen customfield_10003

#GET AVAILABLE SCREEN FIELDS
#Invoke-JiraGetAvailableScreenFields 1

#end tests

#close the Jira session
Close-JiraSession