#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-user-search-get
function Invoke-JiraFindUsers {
    [CmdletBinding()]
    param (
        # A string will be used to search for users (will match against name and email address), must match from start of words
        [Parameter(Mandatory,Position=0)]
        [string]
        $SearchTerm,

        # The list index to start at if results are to be paginated
        [Parameter(Position=1)]
        [int32]
        $StartAt=0,

        # The Maximum results to be returned with the request
        [Parameter(Position=2)]
        [ValidateRange(1,1000)]
        [int32]
        $MaxResults=50,

        # The JiraConnection object to use for the request
        [Parameter()]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/user/search"
        $verb = "GET"

        $query=@{
            query = $SearchTerm
            startAt = $StartAt
            maxResults = $MaxResults
        }

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod $verb -Query $query
    }
}