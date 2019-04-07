$JiraVersionStatus = @("released","unreleased","archived")
$JiraVersionExpand = @("issuestatus","operations")

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-project-projectIdOrKey-version-get
function Invoke-JiraGetProjectVersionsPaginated {
    [CmdletBinding()]
    param (
        # The project ID or project key (case sensitive).
        [Parameter(Mandatory,Position=0)]
        [string]
        $ProjectIdOrKey,

        # Filters the results using a case-insenstive match to project name and key
        [Parameter(Position=1)]
        [string]
        $Filter,

        # Filters the results by a set of Version statuses
        [Parameter(Position=2)]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({ Compare-StringArraySubset $JiraVersionStatus $_ })]
        [string[]]
        $StatusFilter=$JiraVersionStatus,

        # The index of the first item to return in the page of results (page offset). The base index is 0.
        [Parameter(Position=3)]
        [int64]
        $StartAt=0,

        # The maximum number of items to return per page. The default is 50 and the maximum is 50.
        [Parameter(Position=4)]
        [ValidateRange(1,50)]
        [int32]
        $MaxResults=50,

        # Use this to order the results
        [Parameter(Position=5)]
        [ValidateSet("description", "-description", "+description", "name", "-name", "+name", "releaseDate",
                     "-releaseDate", "+releaseDate", "sequence", "-sequence", "+sequence", "startDate",
                     "-startDate", "+startDate")]
        [string]
        $OrderBy,

        # Returns all possible operations for the issue.
        [Parameter(Position=6)]
        [ValidateScript({ Compare-StringArraySubset $JiraVersionExpand $_ })]
        [string[]]
        $Expand,
        
        # The JiraConnection object to use for the request
        [Parameter(Position=7)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/project/$ProjectIdOrKey/version"
        $verb = "GET"

        $query = @{
            startAt = $StartAt
            maxResults = $MaxResults
            status = $StatusFilter -join ","
        }
        if($PSBoundParameters.ContainsKey("Expand")){$query.Add("expand",$Expand -join ",")}
        if($PSBoundParameters.ContainsKey("Filter")){$query.Add("query",$Filter)}
        if($PSBoundParameters.ContainsKey("OrderBy")){$query.Add("orderBy",$OrderBy)}

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod $verb -Query $query -Query $query
    }
}