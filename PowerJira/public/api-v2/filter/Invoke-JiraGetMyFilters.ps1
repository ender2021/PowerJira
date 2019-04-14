$JiraFilterExpand = @("^sharedUsers(\[\d{1,4}\:\d{1,4}\])?$","^subscriptions(\[\d{1,4}\:\d{1,4}\])?$")

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-filter-my-get
function Invoke-JiraGetMyFilters {
    [CmdletBinding()]
    param (
        # Set this flag to include the user's favourited filters as well
        [Parameter()]
        [switch]
        $Favourites,

        # Used to expand additional attributes
        [Parameter(Position=0)]
        [ValidateScript({ Compare-StringArraySubset $JiraFilterExpand $_ -Regex })]
        [string[]]
        $Expand,

        # The JiraConnection object to use for the request
        [Parameter(Position=1)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/filter/my"
        $verb = "GET"

        $query=@{}
        if($PSBoundParameters.ContainsKey("Expand")){$query.Add("expand",$Expand -join ",")}
        if($PSBoundParameters.ContainsKey("Favourites")){$query.Add("includeFavourites",$true)}

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Query $query
    }
}