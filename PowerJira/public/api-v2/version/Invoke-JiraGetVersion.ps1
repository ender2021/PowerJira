#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-version-id-GET
function Invoke-JiraGetVersion {
    [CmdletBinding()]
    param (
        # The ID of the version to update
        [Parameter(Mandatory=$true)]
        [int32]
        $VersionId,

        # Returns all possible operations for the issue.
        [Parameter(Mandatory=$false)]
        [Switch]
        $ExpandOperations,

        # Returns the count of issues in this version for each of the status categories to do,
        # in progress, done, and unmapped. The unmapped property contains a count of issues with
        # a status other than to do, in progress, and done.
        [Parameter(Mandatory=$false)]
        [Switch]
        $ExpandIssuesStatusCount,

        # The JiraConnection object to use for the request
        [Parameter(Mandatory=$false)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/version/$VersionId"
        
        $expand = @()
        if($PSBoundParameters.ContainsKey("ExpandOperations")){$expand += "operations"}
        if($PSBoundParameters.ContainsKey("ExpandIssuesStatusCount")){$expand += "issuesstatus"}
        
        $body = @{}
        if($expand.Count -gt 0) {$body.Add("expand",$expand -join ",")}
        
        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "GET" -Body $body
    }
}