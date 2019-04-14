#import PowerJira
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \..\PowerJira\PowerJira.psm1) -Force

#import the variable $JiraCredentials
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \credentials\Credentials.psm1) -Force

#open a new Jira session
Open-JiraSession -UserName $JiraCredentials.UserName -Password $JiraCredentials.ApiToken -HostName $JiraCredentials.HostName

#do tests here

#GET ISSUE TYPE
#Invoke-JiraGetIssueType 10000

#GET ALTERNATIVE ISSUES TYPES
#Invoke-JiraGetAlternativeIssueTypes 10000

#ADD ISSUE TYPE AVATAR
#$item = get-item $PSScriptRoot\icon.png
#Invoke-JiraAddIssueTypeAvatar 10000 $item

#end tests

#close the Jira session
Close-JiraSession