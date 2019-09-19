#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-users-search-get
function Invoke-JiraGetAllUsers {
    [CmdletBinding()]
    param (
        # The list index to start at if results are to be paginated
        [Parameter(Position=0)]
        [int32]
        $StartAt=0,

        # The Maximum results to be returned with the request
        [Parameter(Position=1)]
        [ValidateRange(1,1000)]
        [int32]
        $MaxResults=50,
        
        # The JiraConnection object to use for the request
        [Parameter(Position=2)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/users/search"
        $verb = "GET"

        $query = @{
            startAt = $StartAt
            maxResults = $MaxResults
        }

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Query $query
    }
}