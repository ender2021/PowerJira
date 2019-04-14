$JiraFilterExpand = @("^sharedUsers(\[\d{1,4}\:\d{1,4}\])?$","^subscriptions(\[\d{1,4}\:\d{1,4}\])?$")

#
function Invoke-JiraAddFavouriteFilter {
    [CmdletBinding()]
    param (
        # The filter id
        [Parameter(Mandatory,Position=0)]
        [int64]
        $FilterId,

        # Used to expand additional attributes
        [Parameter(Position=1)]
        [ValidateScript({ Compare-StringArraySubset $JiraFilterExpand $_ -Regex })]
        [string[]]
        $Expand,

        # The JiraConnection object to use for the request
        [Parameter(Position=2)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/filter/$FilterId/favourite"
        $verb = "PUT"

        $query=@{}
        if($PSBoundParameters.ContainsKey("Expand")){$query.Add("expand",$Expand -join ",")}

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Query $query
    }
}