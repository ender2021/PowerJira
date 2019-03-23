#import PowerJira
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \..\PowerJira.psm1) -Force

#import the variable $JiraCredentials
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \credentials\Credentials.psm1) -Force

#open a new Jira session
Open-JiraSession -UserName $JiraCredentials.UserName -Password $JiraCredentials.ApiToken -HostName $JiraCredentials.HostName

#do tests here

#CREATE COMPONENT
#Invoke-JiraCreateComponent JPT "Test Component 3" "This one has a description" (Invoke-JiraGetCurrentUser).accountId "COMPONENT_LEAD"

#end tests

#close the Jira session
Close-JiraSession