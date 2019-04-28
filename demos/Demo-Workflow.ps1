#import PowerJira
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \..\PowerJira\PowerJira.psm1) -Force

#import the variable $JiraCredentials
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath \credentials\Credentials.psm1) -Force

#open a new Jira session
Open-JiraSession -UserName $JiraCredentials.UserName -Password $JiraCredentials.ApiToken -HostName $JiraCredentials.HostName

#do tests here

#GET ALL WORKFLOWS
#Invoke-JiraGetAllWorkflows

#GET DEFAULT WORKFLOW
#Invoke-JiraGetDefaultWorkflow 10000 -Draft

#GET WORKFLOW SCHEME
#Invoke-JiraGetWorkflowScheme 10000

#GET WORKFLOW SCHEME DRAFT
#Invoke-JiraGetWorkflowSchemeDraft 10000

#GET DRAFT DEFAULT WORKFLOW 
#Invoke-JiraGetDraftDefaultWorkflow 10000

#GET WORKFLOW TRANSITION PROPERTIES
#Invoke-JiraGetWorkflowTransitionProperties "Software Simplified Workflow for Project JPT" 11 -IncludeReserved

#GET ISSUE TYPE WORKFLOW
#Invoke-JiraGetIssueTypeWorkflow 10103 10002

#GET DRAFT ISSUE TYPE WORKFLOW
#Invoke-JiraGetDraftIssueTypeWorkflow 10103 10001

#GET ISSUE TYPES WORKFLOWS
#Invoke-JiraGetIssueTypesWorkflows 10103 "classic default workflow"

#GET DRAFT ISSUE TYPES WORKFLOWS
#Invoke-JiraGetDraftIssueTypesWorkflows 10103

#CREATE WORKFLOW TRANSITION PROPERTY
#Invoke-JiraCreateWorkflowTransitionProperty "Editable Workflow" 11 "newProp" "value of the new property"
#Invoke-JiraGetWorkflowTransitionProperties "Editable Workflow" 11

#UPDATE WORKFLOW TRANSITION PROPERTY
#Invoke-JiraUpdateWorkflowTransitionProperty "Editable Workflow" 11 "newProp" "the value has been changed"

#DELETE WORKFLOW TRANSITION PROPERTY
#Invoke-JiraDeleteWorkflowTransitionProperty "Editable Workflow" 11 "newProp"

#SET DRAFT WORKFLOW ISSUE TYPES
#Invoke-JiraSetDraftWorkflowIssueTypes 10103 jira @(10000,10001)

#SET WORKFLOW ISSUE TYPES
#Invoke-JiraSetWorkflowIssueTypes 10103 jira @(10000,10001)

#SET ISSUE TYPE WORKFLOW
#Invoke-JiraSetIssueTypeWorkflow 10103 10000 jira

#SET DRAFT ISSUE TYPE WORKFLOW
#Invoke-JiraSetDraftIssueTypeWorkflow 10103 10000 jira

#DELETE WORKFLOW ISSUE TYPES
#Invoke-JiraDeleteWorkflowIssueTypes 10103 "classic default workflow"

#DELETE DRAFT WORKFLOW ISSUE TYPES
#Invoke-JiraDeleteDraftWorkflowIssueTypes 10103 "classic default workflow"

#DELETE ISSUE TYPE WORKFLOW
#Invoke-JiraDeleteIssueTypeWorkflow 10103 10000

#end tests

#close the Jira session
Close-JiraSession