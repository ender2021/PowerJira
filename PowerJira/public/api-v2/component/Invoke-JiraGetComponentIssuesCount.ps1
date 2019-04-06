#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-component-id-relatedIssueCounts-get
function Invoke-JiraGetComponentIssuesCount {
    [CmdletBinding()]
    param (
        # The ID of the Component to retrieve
        [Parameter(Mandatory,Position=0)]
        [int32]
        $ComponentId,

        # The JiraConnection object to use for the request
        [Parameter(Position=1)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/component/$ComponentId/relatedIssueCounts"
        $verb = "GET"

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod $verb
    }
}