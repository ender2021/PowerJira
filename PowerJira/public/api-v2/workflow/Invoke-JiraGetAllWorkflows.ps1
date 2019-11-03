#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-group-Workflows
function Invoke-JiraGetAllWorkflows {
    [CmdletBinding()]
    param (
        # The name of  single workflow to return
        [Parameter(Position=0)]
        [string]
        $WorkflowName,

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/workflow"
        $verb = "GET"

        $query = New-Object RestMethodQueryParams
        if($PSBoundParameters.ContainsKey("WorkflowName")){$query.Add("workflowName",$WorkflowName)}

        $method = New-Object RestMethod @($functionPath,$verb,$query)
        $method.Invoke($JiraContext)
    }
}