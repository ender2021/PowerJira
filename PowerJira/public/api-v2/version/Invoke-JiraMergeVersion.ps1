#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-version-id-mergeto-moveIssuesTo-put
function Invoke-JiraMergeVersion {
    [CmdletBinding()]
    param (
        # The ID of the version to merge from
        [Parameter(Mandatory=$true)]
        [int32]
        $SourceVersionId,

        # The ID of the version to merge into
        [Parameter(Mandatory=$true)]
        [int32]
        $TargetVersionId,

        # The JiraConnection object to use for the request
        [Parameter(Mandatory=$false)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/version/$SourceVersionId/mergeto/$TargetVersionId"
    
        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "PUT"
    }
}