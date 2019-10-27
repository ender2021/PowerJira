#import PowerJira
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \..\PowerJira\PowerJira.psm1) -Force

#import the variable $JiraCredentials
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \credentials\Credentials.psm1) -Force

#open a new Jira session
$context = Open-JiraSession -UserName $JiraCredentials.UserName -Password $JiraCredentials.ApiToken -HostName $JiraCredentials.HostName

#do tests here

#CREATE COMPONENT
#Invoke-JiraCreateComponent JPT "Test Component 4" "This one has a description" (Invoke-JiraGetCurrentUser).accountId "COMPONENT_LEAD"

#GET COMPONENT
#Invoke-JiraGetComponent 10001

#UPDATE COMPONENT
#Invoke-JiraUpdateComponent 10001 -DefaultAssignee "UNASSIGNED"

#DELETE COMPONENT
# $comp = Invoke-JiraCreateComponent JPT "To be deleted"
# $comp
# Read-Host -Prompt "Press any key to continue or CTRL+C to quit"
# Invoke-JiraEditIssue JPT-1 @{components=@(@{id=$comp.id})}
# Read-Host -Prompt "Press any key to continue or CTRL+C to quit"
# Invoke-JiraDeleteComponent $comp.id

#GET COMPONENT ISSUES COUNT
#Invoke-JiraGetComponentIssuesCount 10001

#end tests

#close the Jira session
Close-JiraSession