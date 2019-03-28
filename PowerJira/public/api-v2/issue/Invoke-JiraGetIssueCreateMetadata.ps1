#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-createmeta-get
function Invoke-JiraGetIssueCreateMetadata {
    [CmdletBinding()]
    param (
        # IDs of projects to return metadata for
        [Parameter(Mandatory=$false)]
        [int32[]]
        $ProjectIds,

        # Keys of projcts to return metadata for
        [Parameter(Mandatory=$false)]
        [string[]]
        $ProjectKeys,

        # IDs of issue types to return metadata for
        [Parameter(Mandatory=$false)]
        [int32[]]
        $IssueTypeIds,

        # Names of issue types to return metadata for
        [Parameter(Mandatory=$false)]
        [string[]]
        $IssueTypeNames,

        # Expand additional properties
        [Parameter(Mandatory=$false)]
        [Switch]
        $ExpandFields,

        # The JiraConnection object to use for the request
        [Parameter(Mandatory=$false)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issue/createmeta"
        
        $body = @{}
        if($PSBoundParameters.ContainsKey("ProjectIds")){$body.Add("projectIds",$ProjectIds -join ",")}
        if($PSBoundParameters.ContainsKey("ProjectKeys")){$body.Add("projectKeys",$ProjectKeys -join ",")}
        if($PSBoundParameters.ContainsKey("IssueTypeIds")){$body.Add("issuetypeIds",$IssueTypeIds -join ",")}
        if($PSBoundParameters.ContainsKey("IssueTypeNames")){$body.Add("issuetypeNames",$IssueTypeNames  -join ",")}
        if($PSBoundParameters.ContainsKey("ExpandFields")){$body.Add("expand","projects.issuetypes.fields  ")}

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "GET" -Body $body
    }
}