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
        
        # The JiraContext object to use for the request
        [Parameter()]
        [object]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/users/search"
        $verb = "GET"

        $query = New-PACRestMethodQueryParams @{
            startAt = $StartAt
            maxResults = $MaxResults
        }

        $method = New-PACRestMethod $functionPath $verb $query
        $method.Invoke($JiraContext)
    }
}