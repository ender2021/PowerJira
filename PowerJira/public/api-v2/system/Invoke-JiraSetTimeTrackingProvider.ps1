#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-configuration-timetracking-put
function Invoke-JiraSetTimeTrackingProvider {
    [CmdletBinding()]
    param (
        # The key for the time tracking provider
        [Parameter(Mandatory,Position=0)]
        [string]
        $Key,

        # The JiraConnection object to use for the request
        [Parameter(Position=1)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/configuration/timetracking"
        $verb = "PUT"

        $query=@{}
        $body=@{
            key = $Key
        }

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Body $body
    }
}