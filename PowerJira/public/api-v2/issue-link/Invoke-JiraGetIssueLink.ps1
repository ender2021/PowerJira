#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issueLink-linkId-get
function Invoke-JiraGetIssueLink {
    [CmdletBinding()]
    param (
        # The ID of the issue link to be retrieved
        [Parameter(Mandatory,Position=0)]
        [int32]
        $LinkId,

        # The JiraConnection object to use for the request
        [Parameter(Position=1)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issueLink/$LinkId"

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "GET"
    }
}