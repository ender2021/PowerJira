$JiraDashboardExpand = @("description","owner","viewUrl","favourite","favouriteCount","sharePermissions")

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-dashboard-search-get
function Invoke-JiraSearchDashboards {
    [CmdletBinding()]
    param (
        # A name filter to search dashboards with
        [Parameter(Position=0)]
        [string]
        $Name,

        # The account ID of a user that must own result dashboards
        [Parameter(Position=1)]
        [string]
        $OwnerId,

        # The name of a group that result dashboards must be shared with
        [Parameter(Position=2)]
        [string]
        $GroupName,

        # The ID of a project that result dashboards must be shared with
        [Parameter(Position=3)]
        [int64]
        $ProjectId,

        # The field to order results by
        [Parameter(Position=4)]
        [ValidateSet("id", "name", "description", "owner", "favorite_count", "is_favorite",
                    "-id", "-name", "-description", "-owner", "-favorite_count", "-is_favorite")]
        [string]
        $OrderBy="name",

        # The index of the first item to return in the page of results (page offset). The base index is 0.
        [Parameter(Position=5)]
        [int32]
        $StartAt=0,

        # The maximum number of items to return per page. The default is 20 and the maximum is 1000.
        [Parameter(Position=6)]
        [ValidateRange(1,1000)]
        [int32]
        $MaxResults=20,

        # Used to expand additional attributes
        [Parameter(Position=7)]
        [ValidateScript({ Compare-StringArraySubset $JiraDashboardExpand $_ })]
        [string[]]
        $Expand,

        # The JiraConnection object to use for the request
        [Parameter(Position=8)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/dashboard/search"
        $verb = "GET"

        $query=@{
            startAt = $StartAt
            maxResults = $MaxResults
            orderBy = $OrderBy
        }
        if($PSBoundParameters.ContainsKey("Name")){$query.Add("dashboardName",$Name)}
        if($PSBoundParameters.ContainsKey("OwnerId")){$query.Add("accountId",$OwnerId)}
        if($PSBoundParameters.ContainsKey("GroupName")){$query.Add("groupname",$GroupName)}
        if($PSBoundParameters.ContainsKey("ProjectId")){$query.Add("projectId",$ProjectId)}
        if($PSBoundParameters.ContainsKey("Expand")){$query.Add("expand",$Expand -join ",")}

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Query $query
    }
}