#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-group-member-get
function Invoke-JiraGetGroupUsers {
    [CmdletBinding()]
    param (
        # Name of the group for which to get users
        [Parameter(Mandatory,Position=0)]
        [string]
        $Name,

        # The index of the first item to return.  The default is 0.
        [Parameter(Position=1)]
        [int64]
        $StartAt=0,

        # The maximum number of results to return.  This is hard-limited to 50.
        [Parameter(Position=2)]
        [ValidateRange(1,50)]
        [int32]
        $MaxResults=50,

        # Set this flag to include inactive users in the results
        [Parameter(Position=3)]
        [switch]
        $IncludeInactive,

        # The JiraContext object to use for the request
        [Parameter()]
        [object]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/group/member"
        $verb = "GET"

        $query = New-PACRestMethodQueryParams @{
            groupname = $Name
            maxResults = $MaxResults
            startAt = $StartAt
        }
        if($PSBoundParameters.ContainsKey("IncludeInactive")){$query.Add("includeInactiveUsers",$true)}

        $method = New-PACRestMethod $functionPath $verb $query
        $method.Invoke($JiraContext)
    }
}