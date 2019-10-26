#import PowerJira
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \..\PowerJira\PowerJira.psm1) -Force

#import the variable $JiraCredentials
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \credentials\Credentials.psm1) -Force

#open a new Jira session
$context = Open-JiraSession -UserName $JiraCredentials.UserName -Password $JiraCredentials.ApiToken -HostName $JiraCredentials.HostName

#do tests here

#ADD ATTACHMENT
# $txt = Get-Item -Path (Join-Path -Path $PSScriptRoot -ChildPath \SampleAttachment1.txt)
# $png = Get-Item -Path (Join-Path -Path $PSScriptRoot -ChildPath \SampleAttachment2.png)
# Invoke-JiraAddAttachment JPT-1 $txt
# Invoke-JiraAddAttachment JPT-1 $png
#Get-Item -Path $PSScriptRoot\SampleAttachment* | Invoke-JiraAddAttachment JPT-3
#@("JPT-3","JPT-4") | Invoke-JiraAddAttachment -Attachment (Get-Item -Path $PSScriptRoot\SampleAttachment*)

#DELETE ATTACHMENT
#Invoke-JiraDeleteAttachment 10040
#Get-Item -Path $PSScriptRoot\SampleAttachment* | Invoke-JiraAddAttachment JPT-3 | Invoke-JiraDeleteAttachment

#GET ATTACHMENT METADATA
#Invoke-JiraGetAttachmentMetadata 10039
#@(10038,10037,10035) | Invoke-JiraGetAttachmentMetadata

#GET JIRA ATTACHMENT SETTINGS
#Invoke-JiraGetAttachmentSettings

#end tests

#close the Jira session
Close-JiraSession