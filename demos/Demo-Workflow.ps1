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

#end tests

#close the Jira session
Close-JiraSession