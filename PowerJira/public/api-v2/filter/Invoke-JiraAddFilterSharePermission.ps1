#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-filter-id-permission-post
function Invoke-JiraAddFilterSharePermission {
    [CmdletBinding()]
    param (
        # The filter id
        [Parameter(Mandatory,Position=0)]
        [int64]
        $FilterId,

        # The filter share permission to add.  Use New-JiraFilterSharePermission
        [Parameter(Mandatory,Position=1)]
        [hashtable]
        $SharePermission,

        # The JiraConnection object to use for the request
        [Parameter(Position=2)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/filter/$FilterId/permission"
        $verb = "POST"

        $body = $SharePermission

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Body $body
    }
}