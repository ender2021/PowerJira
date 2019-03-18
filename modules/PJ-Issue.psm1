#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-get
function Invoke-JiraGetIssue {
    [CmdletBinding()]
    param (
        # The ID or Key of the issue
        [Parameter(Mandatory=$true)]
        [string]
        $IssueIdOrKey,

        # The JiraConnection object to use for the request
        [Parameter(Mandatory=$false)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issue/$IssueIdOrKey"

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "GET"
    }
}

Export-ModuleMember -Function * -Variable *