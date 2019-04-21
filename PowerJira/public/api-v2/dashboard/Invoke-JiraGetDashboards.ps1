#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-dashboard-get
function Invoke-JiraGetDashboards {
    [CmdletBinding()]
    param (
        # Can bet set to "my" or "favourite" to filter results
        [Parameter(Position=0)]
        [ValidateSet("my","favourite")]
        [string]
        $Filter,

        # The index of the first item to return in the page of results (page offset). The base index is 0.
        [Parameter(Position=1)]
        [int32]
        $StartAt=0,

        # The maximum number of items to return per page. The default is 20 and the maximum is 1000.
        [Parameter(Position=2)]
        [ValidateRange(1,1000)]
        [int32]
        $MaxResults=20,

        # The JiraConnection object to use for the request
        [Parameter(Position=3)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/dashboard"
        $verb = "GET"

        $query=@{
            startAt = $StartAt
            maxResults = $MaxResults
        }
        if($PSBoundParameters.ContainsKey("Filter")){$query.Add("filter",$Filter)}

        (Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Query $query).dashboards
    }
}