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

        # The JiraContext object to use for the request
        [Parameter()]
        [object]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/version/$SourceVersionId/mergeto/$TargetVersionId"
        $verb = "PUT"
    
        $method = New-PACRestMethod $functionPath $verb
        $method.Invoke($JiraContext)
    }
}