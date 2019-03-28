#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-version-id-removeAndSwap-post
function Invoke-JiraDeleteVersion {
    [CmdletBinding()]
    param (
        # The ID of the version to update
        [Parameter(Mandatory=$true)]
        [int32]
        $VersionId,

        # Replacement version for issues with this version in the fixVersions field
        [Parameter(Mandatory=$false)]
        [int32]
        $FixTargetVersionId,

        # Replacement version for issues with this version in the affectsVersions field
        [Parameter(Mandatory=$false)]
        [int32]
        $AffectedTargetVersionId,

        # The JiraConnection object to use for the request
        [Parameter(Mandatory=$false)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/version/$VersionId/removeAndSwap"
        
        $body = @{}
        if($PSBoundParameters.ContainsKey("FixTargetVersionId")){$body.Add("moveFixIssuesTo",$FixTargetVersionId)}
        if($PSBoundParameters.ContainsKey("AffectedTargetVersionId")){$body.Add("moveAffectedIssuesTo",$AffectedTargetVersionId)}
        
        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "POST" -Body $body
    }
}