#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issuetype-id-get
function Invoke-JiraGetIssueType {
    [CmdletBinding()]
    param (
        # The ID of the issue type
        [Parameter(Mandatory,Position=0)]
        [string]
        $IssueTypeId,

        # The JiraConnection object to use for the request
        [Parameter(Position=1)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issuetype/$IssueTypeId"
        $verb = "GET"

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb
    }
}