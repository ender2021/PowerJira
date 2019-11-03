#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-project-projectIdOrKey-component-get
function Invoke-JiraGetProjectComponentsPaginated {
    [CmdletBinding()]
    param (
        # The ID or key of the project to return components for
        [Parameter(Mandatory,Position=0)]
        [string]
        $ProjectIdOrKey,

        # Filters the results using a case-insenstive match to project name and key
        [Parameter(Position=1)]
        [string]
        $Filter,

        # The index of the first item to return in the page of results (page offset). The base index is 0.
        [Parameter(Position=2)]
        [int64]
        $StartAt=0,

        # The maximum number of items to return per page. The default is 50 and the maximum is 50.
        [Parameter(Position=3)]
        [ValidateRange(1,50)]
        [int32]
        $MaxResults=50,

        # Use this to order the results
        [Parameter(Position=4)]
        [ValidateSet("description", "-description", "+descriptionissueCount", "-issueCount",
                     "+issueCountlead", "-lead", "+lead", "name", "-name", "+name")]
        [string]
        $OrderBy,

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/project/$ProjectIdOrKey/component"
        $verb = "GET"

        $query = New-Object RestMethodQueryParams @{
            startAt = $StartAt
            maxResults = $MaxResults
        }
        if($PSBoundParameters.ContainsKey("Filter")){$query.Add("query",$Filter)}
        if($PSBoundParameters.ContainsKey("OrderBy")){$query.Add("orderBy",$OrderBy)}

        $method = New-Object RestMethod @($functionPath,$verb,$query)
        $method.Invoke($JiraContext)
    }
}