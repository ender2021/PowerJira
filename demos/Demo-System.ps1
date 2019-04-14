#import PowerJira
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \..\PowerJira\PowerJira.psm1) -Force

#import the variable $JiraCredentials
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \credentials\Credentials.psm1) -Force

#open a new Jira session
Open-JiraSession -UserName $JiraCredentials.UserName -Password $JiraCredentials.ApiToken -HostName $JiraCredentials.HostName

#do tests here

#GET JIRA INSTANCE INFO
#Invoke-JiraGetInstanceInfo

#GET ALL APPLICATION ROLES
#Invoke-JiraGetAllApplicationRoles

#GET AUDIT RECORDS
#(Invoke-JiraGetAuditRecords "user" -From (Get-Date "3/25/2019 7:18:30 PM") -To (Get-Date) -MaxResults 5).RECORDS

#GET APPLICATION ROLE
#Invoke-JiraGetApplicationRole jira-software

#GET APPLICATION PROPERTY(S)
#Invoke-JiraGetApplicationProperty "jira.clone.prefix"

#SET APPLICATION PROPERTY
# Invoke-JiraGetApplicationProperty "jira.clone.prefix"
# Invoke-JiraSetApplicationProperty "jira.clone.prefix" "Copy - "
# Invoke-JiraSetApplicationProperty "jira.clone.prefix" (Invoke-JiraGetApplicationProperty "jira.clone.prefix").defaultValue

#GET ADVANCED SETTINGS
#Invoke-JiraGetAdvancedSettings

#GET GLOBAL SETTINGS
#Invoke-JiraGetGlobalSettings

#GET SELECTED TIME TRACKING PROVIDER
#Invoke-JiraGetSelectedTimeTrackingProvider

#GET ALL TIME TRACKING PROVIDERs
#Invoke-JiraGetAllTimeTrackingProviders

#GET TIME TRACKING SETTINGS
#Invoke-JiraGetTimeTrackingSettings

#SET TIME TRACKING PROVIDER
#Invoke-JiraSetTimeTrackingProvider "JIRA"

#DISABLE TIME TRACKING
#Invoke-JiraDisableTimeTracking

#end tests

#close the Jira session
Close-JiraSession