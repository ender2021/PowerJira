#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-user-permission-search-get
function Invoke-JiraGetUsersWithPermissions {
    [CmdletBinding(DefaultParameterSetName="Project")]
    param (
        # A project key to set the context of the permissions
        [Parameter(Mandatory,Position=0,ParameterSetName="Project")]
        [ValidateNotNullOrEmpty()]
        [string]
        $ProjectKey,

        # An issue key to set the context of the permissions
        [Parameter(Mandatory,Position=0,ParameterSetName="Issue")]
        [ValidateNotNullOrEmpty()]
        [string]
        $IssueKey,

        # The permisions to check for
        [Parameter(Mandatory,Position=1)]
        [ValidateNotNullOrEmpty()]
        [string[]]
        $Permissions,

        # A search filter for users to return
        [Parameter(Position=2)]
        [string]
        $Filter,

        # The index of the first item to return in the page of results (page offset). The base index is 0.
        [Parameter(Position=3)]
        [int32]
        $StartAt=0,

        # The maximum number of items to return per page. The default is 50 and the maximum is 1000.
        [Parameter(Position=4)]
        [ValidateRange(1,1000)]
        [int32]
        $MaxResults=50,

        # The JiraContext object to use for the request
        [Parameter()]
        [object]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/user/permission/search"
        $verb = "GET"

        $query = New-PACRestMethodQueryParams @{
            permissions = $Permissions -join ","
            startAt = $StartAt
            maxResults = $MaxResults
        }
        if($PSBoundParameters.ContainsKey("ProjectKey")){$query.Add("projectKey",$ProjectKey)}
        if($PSBoundParameters.ContainsKey("IssueKey")){$query.Add("issueKey",$IssueKey)}
        if($PSBoundParameters.ContainsKey("Filter")){$query.Add("query",$Filter)}

        $method = New-PACRestMethod $functionPath $verb $query
        $method.Invoke($JiraContext)
    }
}