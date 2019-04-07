#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-watchers-post
function Invoke-JiraAddWatcher {
    [CmdletBinding()]
    param (
        # The issue Id or Key
        [Parameter(Mandatory,Position=0)]
        [string]
        $IssueIdOrKey,

        # The account ID of the user to add
        [Parameter(Position=1)]
        [string]
        $AccountId,

        # The JiraConnection object to use for the request
        [Parameter(Position=2)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issue/$IssueIdOrKey/watchers"
        $verb = "POST"

        $body=""
        if($PSBoundParameters.ContainsKey("AccountId")){$body = """$AccountId"""}

        Invoke-JiraRestRequest $JiraConnection $functionPath $verb -LiteralBody $body
    }
}