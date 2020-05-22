#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-workflow-transitions-transitionId-properties-delete
function Invoke-JiraDeleteWorkflowTransitionProperty {
    [CmdletBinding()]
    param (
        # The name of the workflow that the transition belongs to
        [Parameter(Mandatory, Position=0)]
        [string]
        $WorkflowName,

        # the ID of the transition
        [Parameter(Mandatory,Position=1)]
        [int64]
        $TransitionId,

        # The key of the property to create
        [Parameter(Mandatory,Position=2)]
        [string]
        $PropertyKey,

        # Set this flag to set the property of the transition on the draft version of the workflow
        [Parameter()]
        [switch]
        $Draft,

        # The JiraContext object to use for the request
        [Parameter()]
        [object]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/workflow/transitions/$TransitionId/properties"
        $verb = "DELETE"

        $query = New-PACRestMethodQueryParams @{
            key = $PropertyKey
            workflowName = $WorkflowName
        }
        if($PSBoundParameters.ContainsKey("Draft")){$query.Add("workflowMode","draft")}

        $method = New-PACRestMethod $functionPath $verb $query
        $method.Invoke($JiraContext)
    }
}