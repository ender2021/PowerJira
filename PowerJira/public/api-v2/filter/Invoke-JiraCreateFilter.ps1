$JiraFilterExpand = @("^sharedUsers(\[\d{1,4}\:\d{1,4}\])?$","^subscriptions(\[\d{1,4}\:\d{1,4}\])?$")

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-filter-post
function Invoke-JiraCreateFilter {
    [CmdletBinding()]
    param (
        # The name to give the filter. Must be unique.
        [Parameter(Mandatory,Position=0)]
        [string]
        $Name,

        # The JQL to define for the filter
        [Parameter(Mandatory,Position=1)]
        [string]
        $Jql,

        # A description for the filter
        [Parameter(Position=2)]
        [string]
        $Description,

        # Used to expand additional attributes
        [Parameter(Position=3)]
        [ValidateScript({ Compare-StringArraySubset $JiraFilterExpand $_ -Regex })]
        [string[]]
        $Expand,

        # Set this flag to indicate that the filter should be added to the users favourites
        [Parameter()]
        [switch]
        $Favourite,

        # The JiraConnection object to use for the request
        [Parameter(Position=4)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/filter"
        $verb = "POST"

        $query=@{}
        if($PSBoundParameters.ContainsKey("Expand")){$query.Add("expand",$Expand -join ",")}

        $body=@{
            name = $Name
            jql = $Jql
            favourite = $false
        }
        if($PSBoundParameters.ContainsKey("Description")){$body.Add("description",$Description)}
        if($PSBoundParameters.ContainsKey("Favourite")){$body.favourite = $true}

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Query $query -Body $body
    }
}