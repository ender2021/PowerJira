#import PowerJira
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \..\PowerJira\PowerJira.psm1) -Force

#import the variable $JiraCredentials
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \credentials\Credentials.psm1) -Force

#open a new Jira session
Open-JiraSession -UserName $JiraCredentials.UserName -Password $JiraCredentials.ApiToken -HostName $JiraCredentials.HostName

#do tests here

#CREATE ISSUE LINK
#Invoke-JiraCreateIssueLink JPT-1 "Blocks" JPT-3 @{body="this complex comment was added with an issue link"}

#GET ISSUE LINK
#Invoke-JiraGetIssueLink (Invoke-JiraGetIssue JPT-1).fields.issueLinks[0].id

#DELETE ISSUE LINK
# Invoke-JiraCreateIssueLink JPT-3 "Blocks" JPT-4
# Read-Host -Prompt "Press any key to continue or CTRL+C to quit"
# Invoke-JiraDeleteIssueLink (Invoke-JiraGetIssue JPT-4).fields.issueLinks[0].id

#GET ISSUE LINK TYPES
#Invoke-JiraGetIssueLinkTypes

#GET ISSUE LINK TYPE
#Invoke-JiraGetIssueLinkType 10003

#CREATE ISSUE LINK TYPE
#Invoke-JiraCreateIssueLinkType "Blame" "Blamed by" "Blames"

#UPDATE ISSUE LINK TYPE
#Invoke-JiraUpdateIssueLinkType 10103 "blamer" "blamer'd" "blame's"

#DELETE ISSUE LINK TYPE
#Invoke-JiraDeleteIssueLinkType 10103
#Invoke-JiraGetIssueLinkTypes

#GET REMOTE ISSUE LINKS
#Invoke-JiraGetRemoteIssueLinks JPT-1

#CREATE OR UPDATE REMOTE ISSUE LINK
# $objectIcon = New-JiraRemoteLinkIcon "http://icons.iconarchive.com/icons/jen/animal/16/Pig-icon.png" "piggy"
# $statusIcon = New-JiraRemoteLinkIcon "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfwvbbZcNf1FMDkr5WHbvB91oeuyYMt28JzeLw8ZWfiBa6QrvLEw" "plus"
# $status = New-JiraRemoteLinkStatus $objectIcon -Resolved
# $ro = New-JiraRemoteObject "https://ucsb-sist.atlassian.net/browse/POW-129" "POW-129" "A linked remote Jira issue" $statusIcon $status
# $app = New-JiraRemoteApplication "com.app.myfakeapp" "My Fake App"
# $globalId = "system=" + $ro.url
# Invoke-JiraCreateOrUpdateRemoteIssueLink JPT-1 $ro $globalId $app "was generated by"

#UPDATE REMOTE ISSUE LINK
#Invoke-JiraUpdateRemoteIssueLink JPT-1 10002 $ro $globalId $app "flipparoo"

#DELETE ISSUE LINK BY ID
#Invoke-JiraDeleteRemoteIssueLink JPT-1 10002

#DELETE ISSUE LINK BY GLOBALID
#Invoke-JiraDeleteRemoteIssueLink JPT-1 -GlobalId $globalId

#end tests

#close the Jira session
Close-JiraSession