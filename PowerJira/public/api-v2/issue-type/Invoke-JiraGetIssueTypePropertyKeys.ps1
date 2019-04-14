#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issuetype-issueTypeId-properties-get
function Invoke-JiraGetIssueTypePropertyKeys {
    [CmdletBinding()]
    param (
        # The issue type ID
        [Parameter(Mandatory,Position=0)]
        [string]
        $IssueTypeId,

        # The JiraConnection object to use for the request
        [Parameter(Position=1)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issuetype/$IssueTypeId/properties"
        $verb = "GET"

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb
    }
}