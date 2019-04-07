#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-groups-picker-get
function Invoke-JiraFindGroups {
    [CmdletBinding()]
    param (
        # The search string to compare to group names
        [Parameter(Mandatory,Position=0)]
        [string]
        $SearchTerm,

        # A list of groups to exclude from the results
        [Parameter(Position=1)]
        [string[]]
        $Exclude,

        # The maximum number of results to return (also governed by an internal jira setting)
        [Parameter(Position=2)]
        [int32]
        $MaxResults,

        # The JiraConnection object to use for the request
        [Parameter(Position=3)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/groups/picker"
        $verb = "GET"

        $queryKvp = @(
            Format-QueryKvp "query" $SearchTerm
        )
        if($Exclude.Count -gt 0) { $Exclude | ForEach-Object {$queryKvp += Format-QueryKvp "exclude" $_} }
        if($PSBoundParameters.ContainsKey("MaxResults")){$queryKvp += Format-QueryKvp "maxResults" $MaxResults}

        Invoke-JiraRestRequest $JiraConnection $functionPath $verb -QueryKvp $queryKvp
    }
}