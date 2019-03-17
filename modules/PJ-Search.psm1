#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-search-post
function Invoke-JiraSearchIssues {
    [CmdletBinding(DefaultParameterSetName="DefaultSearchParams")]
    param (
        # The JiraConnection object to use for the request
        [Parameter(Mandatory=$false)]
        [hashtable]
        $JiraConnection,

        # The JQL string to execute
        [Parameter(Mandatory=$true)]
        [string]
        $Jql,

        # The index of the first item to return in the page of results (page offset). The base index is 0.
        [Parameter(Mandatory=$false)]
        [int32]
        $StartAt=0,

        # The maximum number of items to return per page. The default is 50 and the maximum is 100.
        [Parameter(Mandatory=$false)]
        [ValidateRange(1,100)]
        [int32]
        $MaxResults=50,

        # Array of comma-separated lists of fields to return for each issue, use it to retrieve a subset of fields.
        [Parameter(Mandatory=$false)]
        [string[]]
        $Fields=@("*navigable"),

        # Parameter help description
        [Parameter(Mandatory=$false)]
        [ValidateSet("strict","warn","none")]
        [string]
        $QueryValidation="strict",

        # Parameter help description
        [Parameter(Mandatory=$false)]
        [string[]]
        $Expand,

        # A comma-separated list of up to 5 issue properties to include in the results.
        [Parameter(Mandatory=$false)]
        [ValidateCount(1,5)]
        [string[]]
        $Properties,

        # Reference fields by their key (rather than ID). The default is false.
        [Parameter(Mandatory=$false)]
        [Switch]
        $FieldsByKeys
    )
    process {
        $functionPath = "/rest/api/2/search"

        $body = @{
            jql = $JQL
            startAt = $StartAt
            maxResults = $MaxResults
            fields = $Fields
            validateQuery = $QueryValidation
        }
        if($Expand) {$body.Add("expand",$Expand)}
        if($Properties) {$body.Add("properties",$Properties)}
        if($FieldsByKeys) {$body.Add("fieldsByKeys",$true)}
        
        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "POST" -Body $body
    }
}

Export-ModuleMember -Function * -Variable *