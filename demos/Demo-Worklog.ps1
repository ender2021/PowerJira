#import PowerJira
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \..\PowerJira\PowerJira.psm1) -Force

#import the variable $JiraCredentials
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \credentials\Credentials.psm1) -Force

#open a new Jira session
$context = Open-JiraSession -UserName $JiraCredentials.UserName -Password $JiraCredentials.ApiToken -HostName $JiraCredentials.HostName

#do tests here

#ADD WORKLOG
#Invoke-JiraAddWorklog JPT-1 "2h" "Time formats are a real bastard"

#GET ISSUE WORKLOGS
#(Invoke-JiraGetIssueWorklogs JPT-1 ).worklogs

#GET WORKLOG
#Invoke-JiraGetWorklog JPT-1 10003 -Expand @("properties")

#GET WORKLOG PROPERTY KEYS
#Invoke-JiraGetWorklogPropertyKeys JPT-1 10003

#GET DELETED WORKLOG IDs
#(Invoke-JiraGetDeletedWorklogIds (Format-UnixTimestamp (Get-Date "2019-01-01"))).values

#GET WORKLOGS BY ID
#Invoke-JiraGetWorklogsById @("10003") @("properties")

#GET UPDATED WORKLOG IDs
#Invoke-JiraGetUpdatedWorklogIds

#UPDATE WORKLOG
#Invoke-JiraUpdateWorklog JPT-1 10003 "2m" -Properties @(@{key="someProp";value="fart"})

#GET WORKLOG PROPERTY
#Invoke-JiraGetWorklogProperty JPT-1 10003 "someProp"

#SET WORKLOG PROPERTY
#Invoke-JiraSetWorklogProperty JPT-1 10003 "someProp" @{poop="fart"}

#DELETE WORKLOG PROPERTY
#Invoke-JiraDeleteWorklogProperty JPT-1 10003 "someProp"

#DELETE WORKLOG
#Invoke-JiraDeleteWorklog JPT-1 10003

#end tests

#close the Jira session
Close-JiraSession