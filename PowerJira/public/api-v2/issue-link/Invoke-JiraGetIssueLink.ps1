#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issueLink-linkId-get
function Invoke-JiraGetIssueLink {
    [CmdletBinding()]
    param (
        # The ID of the issue link to be retrieved
        [Parameter(Mandatory,Position=0)]
        [int32]
        $LinkId,

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/issueLink/$LinkId"
        $verb = "GET"

        $method = New-Object RestMethod @($functionPath,$verb)
        $method.Invoke($JiraContext)
    }
}