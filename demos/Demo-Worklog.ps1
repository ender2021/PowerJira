#import PowerJira
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \..\PowerJira\PowerJira.psm1) -Force

#import the variable $JiraCredentials
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \credentials\Credentials.psm1) -Force

#open a new Jira session
Open-JiraSession -UserName $JiraCredentials.UserName -Password $JiraCredentials.ApiToken -HostName $JiraCredentials.HostName

#do tests here

#ADD WORKLOG
#Invoke-JiraAddWorklog JPT-1 "2h" "Time formats are a real bastard"

#GET ISSUE WORKLOGS
#(Invoke-JiraGetIssueWorklogs JPT-1 ).worklogs

#GET WORKLOG
#Invoke-JiraGetWorklog JPT-1 10000

#GET WORKLOG PROPERTY KEYS
#Invoke-JiraGetWorklogPropertyKeys JPT-1 10000

#end tests

#close the Jira session
Close-JiraSession