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

        # Returns field values rendered in HTML format.
        [Parameter(Mandatory=$false)]
        [Switch]
        $ExpandRenderedFields,

        # Returns the display name of each field.
        [Parameter(Mandatory=$false)]
        [Switch]
        $ExpandNames,

        # Returns the schema describing a field type.
        [Parameter(Mandatory=$false)]
        [Switch]
        $ExpandSchema,

        # Returns all possible transitions for the issue.
        [Parameter(Mandatory=$false)]
        [Switch]
        $ExpandTransitions,

        # Returns all possible operations for the issue.
        [Parameter(Mandatory=$false)]
        [Switch]
        $ExpandOperations,

        # Returns information about how each field can be edited.
        [Parameter(Mandatory=$false)]
        [Switch]
        $ExpandEditMetadata,

        # Returns a list of recent updates to an issue, sorted by date, starting from the most recent.
        [Parameter(Mandatory=$false)]
        [Switch]
        $ExpandChangelog,

        # Instead of fields, returns versionedRepresentations a JSON array containing each version of a field's value, with the highest numbered item representing the most recent version.
        [Parameter(Mandatory=$false)]
        [Switch]
        $ExpandVersionedRepresentations,

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
        
        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "POST" -Body $body
    }
}

Export-ModuleMember -Function * -Variable *