#import PowerJira
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \..\PowerJira\PowerJira.psm1) -Force

#import the variable $JiraCredentials
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \credentials\Credentials.psm1) -Force

#open a new Jira session
Open-JiraSession -UserName $JiraCredentials.UserName -Password $JiraCredentials.ApiToken -HostName $JiraCredentials.HostName

#do tests here

#ADD COMMENT
#Invoke-JiraAddComment JPT-1 "by the way, i'm real too"
#(Invoke-JiraSearchIssues -Jql "project = JPT" -GET).issues | Invoke-JiraAddComment "another pipeline comment"

#GET COMMENTS
#(Invoke-JiraGetComments JPT-1).COMMENTS
#(Invoke-JiraSearchIssues -Jql "project = JPT" -GET).issues | Invoke-JiraGetComments

#GET COMMENT
#Invoke-JiraGetComment JPT-1 10000

#GET COMMENTS BY ID
#(Invoke-JiraGetCommentsByIds @(10013,10010,10012) -Expand @("properties")).values
#(Invoke-JiraSearchIssues -Jql "project = JPT" -GET).issues | Invoke-JiraGetComments | Invoke-JiraGetCommentsByIds

#UPDATE COMMENT
#Invoke-JiraUpdateComment "This is another comment from Powershell!" JPT-1 10000 -Visibility (New-JiraVisibility "role" "Administrators")
#(Invoke-JiraSearchIssues -Jql "project = JPT" -GET).issues | Invoke-JiraGetComments | Invoke-JiraUpdateComment "[comment redacted]"

#DELETE COMMENT
#Invoke-JiraDeleteComment JPT-1 10001
#(Invoke-JiraSearchIssues -Jql "project = JPT" -GET).issues | Invoke-JiraGetComments | Invoke-JiraDeleteComment

#GET COMMENT PROPERTY KEYS
#Invoke-JiraGetCommentPropertyKeys 10012
#@(10013,10010,10012) | Invoke-JiraGetCommentPropertyKeys

#SET COMMENT PROPERTY
#Invoke-JiraSetCommentProperty 10010 "twoOnOne" @{someProperty="text";anArray=@("one","two","three")}
#[pscustomobject]@{key="uniqueKey";value=@{someProperty="text";anArray=@("one","two","three")}} | Invoke-JiraSetCommentProperty 10010

#GET COMMENT PROPERTY
#Invoke-JiraGetCommentProperty 10000 "this.is.cool"
#@(10013,10010,10012) | Invoke-JiraGetCommentPropertyKeys | Invoke-JiraGetCommentProperty

#DELETE COMMENT PROPERTY
#Invoke-JiraDeleteCommentProperty 10000 "this.is.cool"

#end tests

#close the Jira session
Close-JiraSession