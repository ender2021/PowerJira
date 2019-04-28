#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-workflowscheme-id-draft-workflow-delete
function Invoke-JiraDeleteDraftWorkflowIssueTypes {
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

        # The JiraConnection object to use for the request
        [Parameter(Position=2)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/workflowscheme/$SchemeId/draft/workflow"
        $verb = "DELETE"

        $query=@{
            workflowName = $WorkflowName
        }

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Query $query
    }
}