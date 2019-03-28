#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-get
function Invoke-JiraGetIssue {
    [CmdletBinding()]
    param (
        # The ID or Key of the issue
        [Parameter(Mandatory=$true)]
        [string]
        $IssueIdOrKey,

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

        # The JiraConnection object to use for the request
        [Parameter(Mandatory=$false)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issue/$IssueIdOrKey"

        $expand = @()
        if($PSBoundParameters.ContainsKey("ExpandRenderedFields")){$expand += "renderedFields"} 
        if($PSBoundParameters.ContainsKey("ExpandNames")){$expand += "names"}
        if($PSBoundParameters.ContainsKey("ExpandSchema")){$expand += "schema"}
        if($PSBoundParameters.ContainsKey("ExpandTransitions")){$expand += "transitions"}
        if($PSBoundParameters.ContainsKey("ExpandOperations")){$expand += "operations"}
        if($PSBoundParameters.ContainsKey("ExpandEditMetadata")){$expand += "editmeta"}
        if($PSBoundParameters.ContainsKey("ExpandVersionedRepresentations")){$expand += "versionedRepresentations"}
        
        $body = @{}
        if($expand.Count -gt 0) {$body.Add("expand",$expand -join ",")}
        
        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "GET" -Body $body
    }
}