#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-get
function Invoke-JiraGetIssue($JiraConnection,$IssueKey,$IssueId) {
    $param = if($IssueKey) { $IssueKey } else { $IssueId }
    $functionPath = "/rest/api/2/issue/$param"

    Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionAddress $functionPath -HttpMethod "GET"
}

Export-ModuleMember -Function * -Variable *