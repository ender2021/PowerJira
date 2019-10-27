#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-workflow-transitions-transitionId-properties-get
function Invoke-JiraGetWorkflowTransitionProperties {
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

        # The key of a specific property to return
        [Parameter(Position=2)]
        [string]
        $PropertyKey,

        # Set this flag to return the properties of the transition on the draft version of the workflow
        [Parameter()]
        [switch]
        $Draft,

        # Set this flag to include reserved keys (properties that cannot be modified)
        [Parameter()]
        [switch]
        $IncludeReserved,

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/workflow/transitions/$TransitionId/properties"
        $verb = "GET"

        $query = [RestMethodQueryParams]::new(@{
            workflowName = $WorkflowName
        })
        if($PSBoundParameters.ContainsKey("PropertyKey")){$query.Add("key",$PropertyKey)}
        if($PSBoundParameters.ContainsKey("Draft")){$query.Add("workflowMode","draft")}
        if($PSBoundParameters.ContainsKey("IncludeReserved")){$query.Add("includeReservedKeys",$IncludeReserved)}

        $method = [RestMethod]::new($functionPath,$verb,$query)
        $method.Invoke($JiraContext)
    }
}