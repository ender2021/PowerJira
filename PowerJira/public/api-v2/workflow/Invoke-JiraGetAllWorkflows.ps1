#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-group-Workflows
function Invoke-JiraGetAllWorkflows {
    [CmdletBinding()]
    param (
        # The name of  single workflow to return
        [Parameter(Position=0)]
        [string]
        $WorkflowName,

        # The JiraConnection object to use for the request
        [Parameter()]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/workflow"
        $verb = "GET"

        $query=@{}
        if($PSBoundParameters.ContainsKey("WorkflowName")){$query.Add("workflowName",$WorkflowName)}

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Query $query
    }
}