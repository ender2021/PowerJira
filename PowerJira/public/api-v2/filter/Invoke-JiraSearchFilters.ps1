$JiraSearchFilterExpand = @("description","favourite","favouritedCount","jql","owner",
                            "searchUrl","sharePermissions","subscriptions","viewUrl")
$JiraSearchFilterOrderBy = @("^\-?id$", "^\-?name$", "^\-?description$", "^\-?owner$",
                             "^\-?favorite_count$", "^\-?is_favorite$")

#
function Invoke-JiraSearchFilters {
    [CmdletBinding()]
    param (
        # String used to perform a case-insensitive partial match with name.
        [Parameter(Position=0)]
        [string]
        $FilterName,

        # User account ID used to return filters with the matching owner
        [Parameter(Position=1)]
        [string]
        $OwnerAccountId,

        # Group name used to returns filters that are shared with a group
        [Parameter(Position=2)]
        [string]
        $GroupName,

        # Project ID used to returns filters that are shared with a project
        [Parameter(Position=3)]
        [int64]
        $ProjectId,

        # The index of the first item to return in the page of results (page offset). The base index is 0.
        [Parameter(Position=4)]
        [int64]
        $StartAt=0,

        # The maximum number of items to return per page. The default is 50 and the maximum is 100.
        [Parameter(Position=5)]
        [ValidateRange(1,100)]
        [int32]
        $MaxResults=50,

        # Used to expand additional attributes
        [Parameter(Position=6)]
        [ValidateScript({ Compare-StringArraySubset $JiraSearchFilterOrderBy @($_) -Regex })]
        [string]
        $OrderBy="Name",

        # Used to expand additional attributes
        [Parameter(Position=7)]
        [ValidateScript({ Compare-StringArraySubset $JiraSearchFilterExpand $_ })]
        [string[]]
        $Expand,

        # The JiraContext object to use for the request
        [Parameter()]
        [object]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/filter/search"
        $verb = "GET"

        $query = New-PACRestMethodQueryParams @{
            startAt = $StartAt
            maxResults = $MaxResults
            orderBy = $OrderBy
        }
        if($PSBoundParameters.ContainsKey("Expand")){$query.Add("expand",$Expand -join ",")}
        if($PSBoundParameters.ContainsKey("FilterName")){$query.Add("filterName",$FilterName)}
        if($PSBoundParameters.ContainsKey("OwnerAccountId")){$query.Add("accountId",$OwnerAccountId)}
        if($PSBoundParameters.ContainsKey("GroupName")){$query.Add("groupname",$GroupName)}
        if($PSBoundParameters.ContainsKey("ProjectId")){$query.Add("projectId",$ProjectId)}

        $method = New-PACRestMethod $functionPath $verb $query
        $method.Invoke($JiraContext)
    }
}