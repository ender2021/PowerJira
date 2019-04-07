$JiraSearchExpand = @("renderedFields","names","schema","transitions","operations","editmeta","changelog","versionedRepresentations")

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-search-post
function Invoke-JiraSearchIssues {
    [CmdletBinding()]
    param (
        # The JQL string to execute
        [Parameter(Mandatory,Position=0)]
        [string]
        $Jql,

        # The index of the first item to return in the page of results (page offset). The base index is 0.
        [Parameter(Position=1)]
        [int32]
        $StartAt=0,

        # The maximum number of items to return per page. The default is 50 and the maximum is 100.
        [Parameter(Position=2)]
        [ValidateRange(1,100)]
        [int32]
        $MaxResults=50,

        # Array of comma-separated lists of fields to return for each issue, use it to retrieve a subset of fields.
        [Parameter(Position=3)]
        [string[]]
        $Fields=@("*navigable"),

        # Parameter help description
        [Parameter(Position=4)]
        [ValidateSet("strict","warn","none")]
        [string]
        $QueryValidation="strict",

        # Used to expand additional attributes
        [Parameter(Position=5)]
        [ValidateScript({ Compare-StringArraySubset $JiraSearchExpand $_ })]
        [string[]]
        $Expand,

        # A comma-separated list of up to 5 issue properties to include in the results.
        [Parameter(Position=6)]
        [ValidateCount(1,5)]
        [string[]]
        $Properties,

        # Reference fields by their key (rather than ID). The default is false.
        [Parameter(Position=7)]
        [Switch]
        $FieldsByKeys,

        # Set this flag to use the GET HTTP verb instead of the default POST
        [Parameter(Position=8)]
        [switch]
        $GET,

        # The JiraConnection object to use for the request
        [Parameter(Position=9)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/search"
        $verb = "POST"

        $body = @{
            jql = $JQL
            startAt = $StartAt
            maxResults = $MaxResults
            fields = $Fields
            validateQuery = $QueryValidation
        }
        if($PSBoundParameters.ContainsKey("Expand")){$body.Add("expand",$Expand -join ",")}
        if($PSBoundParameters.ContainsKey("Properties")){$body.Add("properties",$Properties)}
        if($PSBoundParameters.ContainsKey("FieldsByKeys")){$body.Add("fieldsByKeys",$true)}

        if ($PSBoundParameters.ContainsKey("GET")) {
            $verb = "GET"
            Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod $verb -Query $body
        } else {
            Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod $verb -Body $body
        }
    }
}