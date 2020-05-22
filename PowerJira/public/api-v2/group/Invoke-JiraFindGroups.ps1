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

        # The JiraContext object to use for the request
        [Parameter()]
        [object]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/groups/picker"
        $verb = "GET"

        $query = New-PACRestMethodQueryParams @{
            query = $SearchTerm
        }
        if($Exclude.Count -gt 0) { $Exclude | ForEach-Object {$query.Add("exclude",$_)} }
        if($PSBoundParameters.ContainsKey("MaxResults")){$query.Add("maxResults",$MaxResults)}

        $method = New-PACRestMethod $functionPath $verb $query
        $method.Invoke($JiraContext)
    }
}