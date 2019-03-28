#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-serverInfo-get
function Invoke-JiraGetInstanceInfo {
    [CmdletBinding()]
    param (
        # The JiraConnection object to use for the request
        [Parameter()]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/serverInfo"

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "GET"
    }
}