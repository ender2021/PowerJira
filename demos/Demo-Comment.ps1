#import PowerJira
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \..\PowerJira\PowerJira.psm1) -Force

#import the variable $JiraCredentials
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \credentials\Credentials.psm1) -Force

#open a new Jira session
Open-JiraSession -UserName $JiraCredentials.UserName -Password $JiraCredentials.ApiToken -HostName $JiraCredentials.HostName

#do tests here

#ADD COMMENT
#Invoke-JiraAddComment JPT-1 "by the way, i'm real too"

#GET COMMENTS
#Invoke-JiraGetComments JPT-1

#GET COMMENT
#Invoke-JiraGetComment JPT-1 10000

#GET COMMENTS BY ID
#(Invoke-JiraGetCommentsByIds @(10000,10001,10002) -Expand @("properties")).values

#UPDATE COMMENT
#Invoke-JiraUpdateComment JPT-1 10000 "This is another comment from Powershell!" -Visibility (New-JiraCommentVisibility "role" "Administrators")

#end tests

#close the Jira session
Close-JiraSession