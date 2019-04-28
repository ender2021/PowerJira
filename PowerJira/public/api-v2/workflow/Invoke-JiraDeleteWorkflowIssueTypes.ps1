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

        # The JiraConnection object to use for the request
        [Parameter(Position=2)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/workflowscheme/$SchemeId/workflow"
        $verb = "DELETE"

        $query=@{
            workflowName = $WorkflowName
        }
        if($PSBoundParameters.ContainsKey("UpdateDraft")){$query.Add("updateDraftIfNeeded",$true)}

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Query $query
    }
}