#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issueLink-linkId-delete
function Invoke-JiraDeleteIssueLink {
    [CmdletBinding()]
    param (
        # The ID of the issue link to be retrieved
        [Parameter(Mandatory,Position=0)]
        [int32]
        $LinkId,

        # The JiraContext object to use for the request
        [Parameter()]
        [object]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/issueLink/$LinkId"
        $verb = "DELETE"

        $method = New-PACRestMethod $functionPath $verb
        $method.Invoke($JiraContext)
    }
}