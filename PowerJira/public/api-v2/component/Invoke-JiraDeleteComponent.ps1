#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-component-id-delete
function Invoke-JiraDeleteComponent {
    [CmdletBinding()]
    param (
        # The ID of the Component to update
        [Parameter(Mandatory,Position=0)]
        [int32]
        $ComponentId,

        # The ID of the Component to use to replace this component on issues
        [Parameter(Position=1)]
        [string]
        $MoveIssuesTo,

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/component/$ComponentId"
        $verb = "DELETE"

        $query = [RestMethodQueryParams]::new()
        if($PSBoundParameters.ContainsKey("MoveIssuesTo")){$query.Add("moveIssuesTo",$MoveIssuesTo)}

        $method = [RestMethod]::new($functionPath,$verb,$query)
        $method.Invoke($JiraContext)
    }
}