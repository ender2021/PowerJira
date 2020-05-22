#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issuesecurityschemes-id-get
function Invoke-JiraGetIssueSecurityScheme {
    [CmdletBinding()]
    param (
        # The ID of the security scheme to retrieve
        [Parameter(Mandatory,Position=0)]
        [int64]
        $SchemeId,

        # The JiraContext object to use for the request
        [Parameter()]
        [object]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/issuesecurityschemes/$SchemeId"
        $verb = "GET"

        $method = New-PACRestMethod $functionPath $verb
        $method.Invoke($JiraContext)
    }
}