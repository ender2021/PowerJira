#import PowerJira
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \..\PowerJira.psm1) -Force

#import the variable $JiraCredentials
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \credentials\Credentials.psm1) -Force

#open a new Jira session
Open-JiraSession -UserName $JiraCredentials.UserName -Password $JiraCredentials.ApiToken -HostName $JiraCredentials.HostName

#do tests here

#SEARCH (POST)
#$results = Invoke-JiraSearchIssues -JQL "project = GROPGDIS" -MaxResults 1 -ExpandTransitions -ExpandOperations
#$results.issues[0]

#end tests

#close the Jira session
Close-JiraSession