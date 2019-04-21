#import PowerJira
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \..\PowerJira\PowerJira.psm1) -Force

#import the variable $JiraCredentials
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \credentials\Credentials.psm1) -Force

#open a new Jira session
Open-JiraSession -UserName $JiraCredentials.UserName -Password $JiraCredentials.ApiToken -HostName $JiraCredentials.HostName

#do tests here

#GET DASHBOARDS
#Invoke-JiraGetDashboards "my"

#SEARCH DASHBOARDS
#Invoke-JiraSearchDashboards

#GET DASHBOARD
#Invoke-JiraGetDashboard 10000

#end tests

#close the Jira session
Close-JiraSession