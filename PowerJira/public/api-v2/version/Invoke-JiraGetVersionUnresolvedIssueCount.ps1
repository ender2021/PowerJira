#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-version-id-unresolvedIssueCount-get
function Invoke-JiraGetVersionUnresolvedIssueCount {
    [CmdletBinding()]
    param (
        # The ID of the version
        [Parameter(Mandatory,Position=0)]
        [int32]
        $VersionId,

        # The JiraContext object to use for the request
        [Parameter()]
        [object]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/version/$VersionId/unresolvedIssueCount"
        $verb = "GET"
    
        $method = New-PACRestMethod $functionPath $verb
        $method.Invoke($JiraContext)
    }
}