#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-workflowscheme-id-draft-workflow-put
function Invoke-JiraSetDraftWorkflowIssueTypes {
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

        # Set this flag to indicate that the workflow is the default for the scheme
        [Parameter()]
        [switch]
        $Default,

        # The JiraConnection object to use for the request
        [Parameter(Position=3)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/workflowscheme/$SchemeId/draft/workflow"
        $verb = "PUT"

        $query=@{
            workflowName = $WorkflowName
        }

        $body = @{
            issueTypes = $IssueTypeIds
            workflow = $WorkflowName
        }
        if($PSBoundParameters.ContainsKey("Default")){$body.Add("defaultMapping",$true)}

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Query $query -Body $body
    }
}