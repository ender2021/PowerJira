#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-securitylevel-id-get
function Invoke-JiraGetIssueSecurityLevel {
    [CmdletBinding()]
    param (
        # The ID of the security level to retrieve
        [Parameter(Mandatory,Position=0)]
        [int64]
        $LevelId,

        # The JiraConnection object to use for the request
        [Parameter(Position=1)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/securitylevel/$LevelId"

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "GET"
    }
}