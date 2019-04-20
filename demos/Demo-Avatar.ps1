#import PowerJira
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \..\PowerJira\PowerJira.psm1) -Force

#import the variable $JiraCredentials
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \credentials\Credentials.psm1) -Force

#open a new Jira session
Open-JiraSession -UserName $JiraCredentials.UserName -Password $JiraCredentials.ApiToken -HostName $JiraCredentials.HostName

#do tests here

#GET SYSTEM AVATARS
#Invoke-JiraGetSystemAvatars "issuetype" | fl

#GET AVATARS
#Invoke-JiraGetAvatars "project" 10000 | fl

#ADD AVATAR
#$item = Get-Item $PSScriptRoot\icon.png
#Invoke-JiraAddAvatar "issuetype" 10000 $item

#end tests

#close the Jira session
Close-JiraSession