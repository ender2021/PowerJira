#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-version-id-removeAndSwap-post
function Invoke-JiraDeleteVersion {
    [CmdletBinding()]
    param (
        # The ID of the version to update
        [Parameter(Mandatory,Position=0)]
        [int32]
        $VersionId,

        # Replacement version for issues with this version in the fixVersions field
        [Parameter(Mandatory,Position=1)]
        [int32]
        $FixTargetVersionId,

        # Replacement version for issues with this version in the affectsVersions field
        [Parameter(Mandatory,Position=2)]
        [int32]
        $AffectedTargetVersionId,

        # The JiraConnection object to use for the request
        [Parameter(Position=3)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/version/$VersionId/removeAndSwap"
        $verb = "POST"
        
        $body = @{}
        if($PSBoundParameters.ContainsKey("FixTargetVersionId")){$body.Add("moveFixIssuesTo",$FixTargetVersionId)}
        if($PSBoundParameters.ContainsKey("AffectedTargetVersionId")){$body.Add("moveAffectedIssuesTo",$AffectedTargetVersionId)}
        
        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod $verb -Body $body
    }
}