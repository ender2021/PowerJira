#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-permissions-get
function Invoke-JiraGetAllPermissions {
    [CmdletBinding()]
    param (
        # The JiraConnection object to use for the request
        [Parameter()]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/permissions"
        $verb = "GET"

        (Invoke-JiraRestMethod $JiraConnection $functionPath $verb).permissions
    }
}