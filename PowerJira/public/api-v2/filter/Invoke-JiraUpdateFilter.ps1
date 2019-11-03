$JiraFilterExpand = @("^sharedUsers(\[\d{1,4}\:\d{1,4}\])?$","^subscriptions(\[\d{1,4}\:\d{1,4}\])?$")

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-filter-id-put
function Invoke-JiraUpdateFilter {
    [CmdletBinding()]
    param (
        # The ID of the filter to update
        [Parameter(Mandatory,Position=0)]
        [int64]
        $FilterId,

        # The name to give the filter. Must be unique.
        [Parameter(Position=1)]
        [string]
        $Name,

        # The JQL to define for the filter
        [Parameter(Position=2)]
        [string]
        $Jql,

        # A description for the filter
        [Parameter(Position=3)]
        [string]
        $Description,

        # The groups and projects that the filter is shared with.  Use New-JiraFilterSharePermissions
        [Parameter(Position=4)]
        [hashtable[]]
        $SharePermissions,

        # Used to expand additional attributes
        [Parameter(Position=5)]
        [ValidateScript({ Compare-StringArraySubset $JiraFilterExpand $_ -Regex })]
        [string[]]
        $Expand,

        # Set this value to update the Favourite status of the filter
        [Parameter(Position=6)]
        [bool]
        $Favourite,

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/filter/$FilterId"
        $verb = "PUT"

        $query = New-Object RestMethodQueryParams
        if($PSBoundParameters.ContainsKey("Expand")){$query.Add("expand",$Expand -join ",")}

        $body = New-Object RestMethodJsonBody
        if($PSBoundParameters.ContainsKey("Name")){$body.Add("name",$Name)}
        if($PSBoundParameters.ContainsKey("Jql")){$body.Add("jql",$Jql)}
        if($PSBoundParameters.ContainsKey("Description")){$body.Add("description",$Description)}
        if($PSBoundParameters.ContainsKey("Favourite")){$body.Add("favourite",$Favourite)}
        if($PSBoundParameters.ContainsKey("SharePermissions")){$body.Add("sharePermissions",$SharePermissions)}

        $method = New-Object BodyRestMethod @($functionPath,$verb,$query,$body)
        $method.Invoke($JiraContext)
    }
}