#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-filter-id-permission-permissionId-delete
function Invoke-JiraDeleteFilterSharePermission {
    [CmdletBinding()]
    param (
        # The filter id
        [Parameter(Mandatory,Position=0)]
        [int64]
        $FilterId,

        # The filter share permission id
        [Parameter(Mandatory,Position=1)]
        [int64]
        $SharePermissionId,

        # The JiraConnection object to use for the request
        [Parameter(Position=2)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/filter/$FilterId/permission/$SharePermissionId"
        $verb = "DELETE"

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb
    }
}