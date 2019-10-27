#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-user-assignable-multiProjectSearch-get
function Invoke-JiraGetUsersAssignableToProjects {
    [CmdletBinding()]
    param (
        # An array of project keys to return assignable users for
        [Parameter(Mandatory,Position=0)]
        [ValidateNotNullOrEmpty()]
        [string[]]
        $ProjectKeys,

        # A search filter for users to return
        [Parameter(Position=1)]
        [string]
        $Filter,

        # The index of the first item to return in the page of results (page offset). The base index is 0.
        [Parameter(Position=2)]
        [int32]
        $StartAt=0,

        # The maximum number of items to return per page. The default is 50 and the maximum is 1000.
        [Parameter(Position=3)]
        [ValidateRange(1,1000)]
        [int32]
        $MaxResults=50,

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/user/assignable/multiProjectSearch"
        $verb = "GET"

        $query = [RestMethodQueryParams]::new(@{
            projectKeys = $ProjectKeys -join ","
            startAt = $StartAt
            maxResults = $MaxResults
        })
        if($PSBoundParameters.ContainsKey("Filter")){$query.Add("query",$Filter)}

        $method = [RestMethod]::new($functionPath,$verb,$query)
        $method.Invoke($JiraContext)
    }
}