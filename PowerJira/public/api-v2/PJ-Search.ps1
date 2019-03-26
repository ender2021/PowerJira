#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-search-post
function Invoke-JiraSearchIssues {
    [CmdletBinding(DefaultParameterSetName="DefaultSearchParams")]
    param (
        # The JQL string to execute
        [Parameter(Mandatory=$true,Position=0)]
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
        [Parameter()]
        [string[]]
        $Fields=@("*navigable"),

        # Parameter help description
        [Parameter()]
        [ValidateSet("strict","warn","none")]
        [string]
        $QueryValidation="strict",

        # Returns field values rendered in HTML format.
        [Parameter()]
        [Switch]
        $ExpandRenderedFields,

        # Returns the display name of each field.
        [Parameter()]
        [Switch]
        $ExpandNames,

        # Returns the schema describing a field type.
        [Parameter()]
        [Switch]
        $ExpandSchema,

        # Returns all possible transitions for the issue.
        [Parameter()]
        [Switch]
        $ExpandTransitions,

        # Returns all possible operations for the issue.
        [Parameter()]
        [Switch]
        $ExpandOperations,

        # Returns information about how each field can be edited.
        [Parameter()]
        [Switch]
        $ExpandEditMetadata,

        # Returns a list of recent updates to an issue, sorted by date, starting from the most recent.
        [Parameter()]
        [Switch]
        $ExpandChangelog,

        # Instead of fields, returns versionedRepresentations a JSON array containing each version of a field's value, with the highest numbered item representing the most recent version.
        [Parameter()]
        [Switch]
        $ExpandVersionedRepresentations,

        # A comma-separated list of up to 5 issue properties to include in the results.
        [Parameter()]
        [ValidateCount(1,5)]
        [string[]]
        $Properties,

        # Reference fields by their key (rather than ID). The default is false.
        [Parameter()]
        [Switch]
        $FieldsByKeys,

        # Set this flag to use the GET HTTP verb instead of the default POST
        [Parameter()]
        [switch]
        $GET,

        # The JiraConnection object to use for the request
        [Parameter()]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/search"

        $expand = @()
        if($PSBoundParameters.ContainsKey("ExpandRenderedFields")){$expand += "renderedFields"} 
        if($PSBoundParameters.ContainsKey("ExpandNames")){$expand += "names"}
        if($PSBoundParameters.ContainsKey("ExpandSchema")){$expand += "schema"}
        if($PSBoundParameters.ContainsKey("ExpandTransitions")){$expand += "transitions"}
        if($PSBoundParameters.ContainsKey("ExpandOperations")){$expand += "operations"}
        if($PSBoundParameters.ContainsKey("ExpandEditMetadata")){$expand += "editmeta"}
        if($PSBoundParameters.ContainsKey("ExpandVersionedRepresentations")){$expand += "versionedRepresentations"}
        
        $body = @{
            jql = $JQL
            startAt = $StartAt
            maxResults = $MaxResults
            fields = $Fields
            validateQuery = $QueryValidation
        }
        if($expand.Count -gt 0) {$body.Add("expand",$expand)}
        if($PSBoundParameters.ContainsKey("Expand")){$body.Add("expand",$Expand)}
        if($PSBoundParameters.ContainsKey("Properties")){$body.Add("properties",$Properties)}
        if($PSBoundParameters.ContainsKey("FieldsByKeys")){$body.Add("fieldsByKeys",$true)}
        
        $method = "POST"
        if($PSBoundParameters.ContainsKey("GET")){$method = "GET"}
        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod $method -Body $body
    }
}

Export-ModuleMember -Function * -Variable *