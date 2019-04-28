#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-workflowscheme-id-draft-workflow-get
function Invoke-JiraGetDraftIssueTypesWorkflows {
    [CmdletBinding()]
    param (
        # The id of the scheme
        [Parameter(Mandatory,Position=0)]
        [int64]
        $SchemeId,

        # Supply a workflow name to get issue types for a specific workflow in the scheme
        [Parameter(Position=1)]
        [string]
        $WorkflowName,

        # The JiraConnection object to use for the request
        [Parameter(Position=2)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/workflowscheme/$SchemeId/draft/workflow"
        $verb = "GET"

        $query=@{}
        if($PSBoundParameters.ContainsKey("WorkflowName")){$query.Add("workflowName",$WorkflowName)}

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Query $query
    }
}