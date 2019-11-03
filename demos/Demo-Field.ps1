#import PowerJira
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \..\PowerJira\PowerJira.psm1) -Force

#import the variable $JiraCredentials
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \credentials\Credentials.psm1) -Force

#open a new Jira session
Open-JiraSession -UserName $JiraCredentials.UserName -Password $JiraCredentials.ApiToken -HostName $JiraCredentials.HostName

#do tests here

#GET FIELDS
#Invoke-JiraGetFields
# $fields = Invoke-JiraGetFields
# $fields.GetEnumerator() | Where-Object {$_.navigable -eq "True"} | sort {$_.id} | Export-Csv $PSScriptRoot\fields.csv

#CREATE CUSTOM FIELD
#Invoke-JiraCreateCustomField "My REST Date" "datepicker" "I created this field using REST!"

#GET CUSTOM FIELD OPTION
#Invoke-JiraGetCustomFieldOption customfield_10029

#end tests

#close the Jira session
Close-JiraSession