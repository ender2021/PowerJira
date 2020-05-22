# https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-status-idOrName-get
function Invoke-JiraGetStatus {
    [CmdletBinding()]
    param (
        # The status Id or name
        [Parameter(Mandatory,Position=0)]
        [string]
        $StatusIdOrName,

        # The JiraContext object to use for the request
        [Parameter()]
        [object]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/status/$StatusIdOrName"
        $verb = "GET"

        $method = New-PACRestMethod $functionPath $verb
        $method.Invoke($JiraContext)
    }
}