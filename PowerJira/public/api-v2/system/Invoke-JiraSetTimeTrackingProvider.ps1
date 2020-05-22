#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-configuration-timetracking-put
function Invoke-JiraSetTimeTrackingProvider {
    [CmdletBinding()]
    param (
        # The key for the time tracking provider
        [Parameter(Mandatory,Position=0)]
        [string]
        $Key,

        # The JiraContext object to use for the request
        [Parameter()]
        [object]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/configuration/timetracking"
        $verb = "PUT"

        $body = New-PACRestMethodJsonBody @{
            key = $Key
        }

        $method = New-PACRestMethod $functionPath $verb $null $body
        $method.Invoke($JiraContext)
    }
}