#import PowerJira
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \..\PowerJira\PowerJira.psm1) -Force

#import the variable $JiraCredentials
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \credentials\Credentials.psm1) -Force

#open a new Jira session
Open-JiraSession -UserName $JiraCredentials.UserName -Password $JiraCredentials.ApiToken -HostName $JiraCredentials.HostName

#do tests here

#GET SYSTEM AVATARS
#Invoke-JiraGetSystemAvatars "issuetype" | fl
#"project" | Invoke-JiraGetSystemAvatars | fl

#GET AVATARS
#(Invoke-JiraGetAvatars "issuetype" 10000).custom
#(Invoke-JiraGetProject 10000).issuetypes | Invoke-JiraGetAvatars issuetype

#ADD AVATAR
#Get-Item $PSScriptRoot\icon.png | Invoke-JiraAddAvatar "issuetype" 10000

#DELETE AVATAR
#Invoke-JiraDeleteAvatar "issuetype" 10000 10514
#(Invoke-JiraGetAvatars "issuetype" 10000).custom | Invoke-JiraDeleteAvatar "issuetype" 10000

#end tests

#close the Jira session
Close-JiraSession