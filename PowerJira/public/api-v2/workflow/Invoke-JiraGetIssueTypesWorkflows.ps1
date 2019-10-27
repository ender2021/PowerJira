#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-workflowscheme-id-workflow-get
function Invoke-JiraGetIssueTypesWorkflows {
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

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/workflowscheme/$SchemeId/workflow"
        $verb = "GET"

        $query = [RestMethodQueryParams]::new()
        if($PSBoundParameters.ContainsKey("WorkflowName")){$query.Add("workflowName",$WorkflowName)}
        if($PSBoundParameters.ContainsKey("Draft")){$query.Add("returnDraftIfExists",$true)}

        $method = [RestMethod]::new($functionPath,$verb,$query)
        $method.Invoke($JiraContext)
    }
}