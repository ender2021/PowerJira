#import PowerJira
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \..\PowerJira\PowerJira.psm1) -Force

#import the variable $JiraCredentials
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \credentials\Credentials.psm1) -Force

#open a new Jira session
Open-JiraSession -UserName $JiraCredentials.UserName -Password $JiraCredentials.ApiToken -HostName $JiraCredentials.HostName

#do tests here

#SEARCH (POST)
#$results = Invoke-JiraSearchIssues -JQL "project = GROPGDIS" -MaxResults 1
#$results.issues[0]

#SEARCH (GET)
# $results = Invoke-JiraSearchIssues -JQL "project = JPT" -GET
# $results.issues | Format-List

#EVALUTE EXPRESSION
# $expression = "issue.comments.filter(c => c.author.accountId == user.accountId).map(c => c.body)"
# $context = New-JiraExpressionContext JPT-1
# (Invoke-JiraEvaluateExpression $expression $context).value

#GET FIELD REFERENCE DATA
#Invoke-JiraGetFieldReferenceData | fl

#GET FIELD AUTOCOMPLETE SUGGESTIONS
#Invoke-JiraGetFieldAutocompleteSuggestions "project" "jpt"

#REPLACE PERSONAL IDENTIFIERS
#Invoke-JiraReplacePersonalIdentifiers @('reporter = admin')

#end tests

#close the Jira session
Close-JiraSession