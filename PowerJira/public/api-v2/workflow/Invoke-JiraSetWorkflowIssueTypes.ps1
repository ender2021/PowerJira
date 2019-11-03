#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-workflowscheme-id-workflow-put
function Invoke-JiraSetWorkflowIssueTypes {
    [CmdletBinding()]
    param (
        # The id of the scheme
        [Parameter(Mandatory,Position=0)]
        [int64]
        $SchemeId,

        # The workflow to set issue types for
        [Parameter(Mandatory,Position=1)]
        [string]
        $WorkflowName,

        # The issue types to assign to the workflow
        [Parameter(Mandatory,Position=2)]
        [int64[]]
        $IssueTypeIds,

        # Set this flag to indicate the workflow is the default for the scheme
        [Parameter()]
        [switch]
        $Default,

        # Set this flag to update a draft if the workflow is currently being used
        [Parameter()]
        [switch]
        $UpdateDraft,

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/workflowscheme/$SchemeId/workflow"
        $verb = "PUT"

        $query = New-Object RestMethodQueryParams @{
            workflowName = $WorkflowName
        }

        $body = New-Object RestMethodJsonBody @{
            issueTypes = $IssueTypeIds
            workflow = $WorkflowName
        }
        if($PSBoundParameters.ContainsKey("Default")){$body.Add("defaultMapping",$true)}
        if($PSBoundParameters.ContainsKey("UpdateDraft")){$body.Add("updateDraftIfNeeded",$true)}

        $method = New-Object BodyRestMethod @($functionPath,$verb,$query,$body)
        $method.Invoke($JiraContext)
    }
}