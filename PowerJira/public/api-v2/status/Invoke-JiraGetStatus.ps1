# https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-status-idOrName-get
function Invoke-JiraGetStatus {
    [CmdletBinding()]
    param (
        # The status Id or name
        [Parameter(Mandatory,Position=0)]
        [string]
        $StatusIdOrName,

        # The JiraConnection object to use for the request
        [Parameter(Position=1)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/status/$StatusIdOrName"
        $verb = "GET"

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod $verb
    }
}