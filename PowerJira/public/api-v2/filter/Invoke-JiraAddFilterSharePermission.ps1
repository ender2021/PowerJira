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

        # The JiraContext object to use for the request
        [Parameter()]
        [object]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/filter/$FilterId/permission"
        $verb = "POST"

        $body = New-PACRestMethodJsonBody $SharePermission

        $method = New-PACRestMethod $functionPath $verb $null $body
        $method.Invoke($JiraContext)
    }
}