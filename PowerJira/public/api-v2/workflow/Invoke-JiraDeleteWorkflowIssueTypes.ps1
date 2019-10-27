#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-workflowscheme-id-workflow-delete
function Invoke-JiraDeleteWorkflowIssueTypes {
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
        $verb = "DELETE"

        $query = New-Object RestMethodQueryParams @{
            workflowName = $WorkflowName
        }
        if($PSBoundParameters.ContainsKey("UpdateDraft")){$query.Add("updateDraftIfNeeded",$true)}

        $method = New-Object RestMethod @($functionPath,$verb,$query)
        $method.Invoke($JiraContext)
    }
}