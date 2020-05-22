#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-screens-get
function Invoke-JiraGetAllScreens {
    [CmdletBinding()]
    param (
        # The index of the first item to return in the page of results (page offset). The base index is 0.
        [Parameter(Position=0)]
        [int32]
        $StartAt=0,

        # The maximum number of items to return per page. The default is 100 and the maximum is 100.
        [Parameter(Position=1)]
        [ValidateRange(1,100)]
        [int32]
        $MaxResults=20,

        # The JiraContext object to use for the request
        [Parameter()]
        [object]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/screens"
        $verb = "GET"

        $query = New-PACRestMethodQueryParams @{
            startAt = $StartAt
            maxResults = $MaxResults
        }

        $method = New-PACRestMethod $functionPath $verb $query
        $method.Invoke($JiraContext)
    }
}