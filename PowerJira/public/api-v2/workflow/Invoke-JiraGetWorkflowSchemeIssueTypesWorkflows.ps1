#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-workflowscheme-id-workflow-get
function Invoke-JiraGetWorkflowSchemeIssueTypesWorkflows {
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

        # Set this flag to return the default workflow of the scheme's draft (instead of the published version)
        [Parameter()]
        [switch]
        $Draft,

        # The JiraConnection object to use for the request
        [Parameter(Position=2)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/workflowscheme/$SchemeId/workflow"
        $verb = "GET"

        $query=@{}
        if($PSBoundParameters.ContainsKey("WorkflowName")){$query.Add("workflowName",$WorkflowName)}
        if($PSBoundParameters.ContainsKey("Draft")){$query.Add("returnDraftIfExists",$true)}

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Query $query
    }
}