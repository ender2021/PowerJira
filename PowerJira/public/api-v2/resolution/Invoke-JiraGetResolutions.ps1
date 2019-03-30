#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-resolution-get
function Invoke-JiraGetResolutions {
    [CmdletBinding()]
    param (
        # The JiraConnection object to use for the request
        [Parameter(Position=0)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/resolution"

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "GET"
    }
}