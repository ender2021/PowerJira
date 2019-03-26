#import PowerJira
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \..\PowerJira\PowerJira.psm1) -Force

#import the variable $JiraCredentials
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \credentials\Credentials.psm1) -Force

#open a new Jira session
Open-JiraSession -UserName $JiraCredentials.UserName -Password $JiraCredentials.ApiToken -HostName $JiraCredentials.HostName

#do tests here

#ADD ATTACHMENT
# $txt = Get-Item -Path (Join-Path -Path $PSScriptRoot -ChildPath \SampleAttachment1.txt)
# $png = Get-Item -Path (Join-Path -Path $PSScriptRoot -ChildPath \SampleAttachment2.png)
# Invoke-JiraAddAttachment JPT-1 $txt
# Invoke-JiraAddAttachment JPT-1 $png

#DELETE ATTACHMENT
#Invoke-JiraDeleteAttachment 10001

#end tests

#close the Jira session
Close-JiraSession