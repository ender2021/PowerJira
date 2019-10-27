#import PowerJira
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \..\PowerJira\PowerJira.psm1) -Force

#import the variable $JiraCredentials
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \credentials\Credentials.psm1) -Force

#open a new Jira session
$context = Open-JiraSession -UserName $JiraCredentials.UserName -Password $JiraCredentials.ApiToken -HostName $JiraCredentials.HostName

#do tests here

#GET DASHBOARDS
#Invoke-JiraGetDashboards

#SEARCH DASHBOARDS
#Invoke-JiraSearchDashboards

#GET DASHBOARD
#Invoke-JiraGetDashboard 10000

#GET DASHBOARD ITEM PROPERTY KEYS
#Invoke-JiraGetDashboardItemPropertyKeys 10000 10000

#SET DASHBOARD ITEM PROPERTY
#Invoke-JiraSetDashboardItemProperty 10000 10000 "prop" @{obj="json"}

#GET DASHBOARD ITEM PROPERTY
#Invoke-JiraGetDashboardItemProperty 10000 10000 "prop"

#DELETE DASHBOARD ITEM PROPERTY
#Invoke-JiraDeleteDashboardItemProperty 10000 10000 "prop"

#end tests

#close the Jira session
Close-JiraSession