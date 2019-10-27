$JiraFilterExpand = @("^sharedUsers(\[\d{1,4}\:\d{1,4}\])?$","^subscriptions(\[\d{1,4}\:\d{1,4}\])?$")

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-filter-favourite-get
function Invoke-JiraGetFavouriteFilters {
    [CmdletBinding()]
    param (
        # Used to expand additional attributes
        [Parameter(Position=0)]
        [ValidateScript({ Compare-StringArraySubset $JiraFilterExpand $_ -Regex })]
        [string[]]
        $Expand,

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/filter/favourite"
        $verb = "GET"

        $query = New-Object RestMethodQueryParams
        if($PSBoundParameters.ContainsKey("Expand")){$query.Add("expand",$Expand -join ",")}

        $method = New-Object RestMethod @($functionPath,$verb,$query)
        $method.Invoke($JiraContext)
    }
}