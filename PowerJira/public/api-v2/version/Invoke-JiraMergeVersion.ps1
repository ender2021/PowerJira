#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-version-id-mergeto-moveIssuesTo-put
function Invoke-JiraMergeVersion {
    [CmdletBinding()]
    param (
        # The ID of the version to merge from
        [Parameter(Mandatory,Position=0)]
        [int32]
        $SourceVersionId,

        # The ID of the version to merge into
        [Parameter(Mandatory,Position=1)]
        [int32]
        $TargetVersionId,

        # The JiraConnection object to use for the request
        [Parameter(Position=2)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/version/$SourceVersionId/mergeto/$TargetVersionId"
        $verb = "PUT"
    
        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod $verb
    }
}