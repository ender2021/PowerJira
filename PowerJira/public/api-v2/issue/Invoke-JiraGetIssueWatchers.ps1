#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-watchers-get
function Invoke-JiraGetIssueWatchers {
    [CmdletBinding()]
    param (
        # The issue Id or Key
        [Parameter(Mandatory,Position=0)]
        [string]
        $IssueIdOrKey,

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/issue/$IssueIdOrKey/watchers"
        $verb = "GET"

        $method = [RestMethod]::new($functionPath,$verb)
        $method.Invoke($JiraContext)
    }
}