#import PowerJira
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \..\PowerJira.psm1) -Force

#import the variable $JiraCredentials
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \credentials\Credentials.psm1) -Force

#open a new Jira session
Open-JiraSession -UserName $JiraCredentials.UserName -Password $JiraCredentials.ApiToken -HostName $JiraCredentials.HostName

#do tests here

#CREATE ISSUE LINK
#Invoke-JiraCreateIssueLink JPT-2 "Precedent" JPT-3 @{body="this complex comment was added with an issue link";visibility=@{type="role";value="Administrators"}}

#GET ISSUE LINK
#Invoke-JiraGetIssueLink (Invoke-JiraGetIssue JPT-1).fields.issueLinks[0].id

#DELETE ISSUE LINK
# Invoke-JiraCreateIssueLink JPT-3 "Precedent" JPT-4
# Read-Host -Prompt "Press any key to continue or CTRL+C to quit"
# Invoke-JiraDeleteIssueLink (Invoke-JiraGetIssue JPT-4).fields.issueLinks[0].id

#GET ISSUE LINK TYPES
Invoke-JiraGetIssueLinkTypes


#end tests

#close the Jira session
Close-JiraSession