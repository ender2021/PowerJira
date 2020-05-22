#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-securitylevel-id-get
function Invoke-JiraGetIssueSecurityLevel {
    [CmdletBinding()]
    param (
        # The ID of the security level to retrieve
        [Parameter(Mandatory,Position=0)]
        [int64]
        $LevelId,

        # The JiraContext object to use for the request
        [Parameter()]
        [object]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/securitylevel/$LevelId"
        $verb = "GET"

        $method = New-PACRestMethod $functionPath $verb
        $method.Invoke($JiraContext)
    }
}