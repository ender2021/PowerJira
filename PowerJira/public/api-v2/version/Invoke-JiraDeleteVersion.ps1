#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-version-id-removeAndSwap-post
function Invoke-JiraDeleteVersion {
    [CmdletBinding()]
    param (
        # The ID of the version to update
        [Parameter(Mandatory,Position=0)]
        [int32]
        $VersionId,

        # Replacement version for issues with this version in the fixVersions field
        [Parameter(Position=1)]
        [int32]
        $FixTargetVersionId,

        # Replacement version for issues with this version in the affectsVersions field
        [Parameter(Position=2)]
        [int32]
        $AffectedTargetVersionId,

        # The JiraContext object to use for the request
        [Parameter()]
        [object]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/version/$VersionId/removeAndSwap"
        $verb = "POST"
        
        $body = New-PACRestMethodJsonBody
        if($PSBoundParameters.ContainsKey("FixTargetVersionId")){$body.Add("moveFixIssuesTo",$FixTargetVersionId)}
        if($PSBoundParameters.ContainsKey("AffectedTargetVersionId")){$body.Add("moveAffectedIssuesTo",$AffectedTargetVersionId)}
        
        $method = New-PACRestMethod $functionPath $verb $null $body
        $method.Invoke($JiraContext)
    }
}