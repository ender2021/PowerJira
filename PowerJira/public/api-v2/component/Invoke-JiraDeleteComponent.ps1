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

        # The JiraConnection object to use for the request
        [Parameter(Position=2)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/component/$ComponentId"
        $verb = "DELETE"

        $body=@{}
        if($PSBoundParameters.ContainsKey("MoveIssuesTo")){$body.Add("moveIssuesTo",$MoveIssuesTo)}

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod $verb -Body $body
    }
}