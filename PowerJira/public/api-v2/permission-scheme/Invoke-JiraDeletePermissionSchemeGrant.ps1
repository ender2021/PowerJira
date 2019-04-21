#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-permissionscheme-schemeId-permission-permissionId-delete
function Invoke-JiraDeletePermissionSchemeGrant {
    [CmdletBinding()]
    param (
        # The ID of the scheme to retrieve
        [Parameter(Mandatory,Position=0)]
        [int64]
        $SchemeId,

        # The id of the permission to retrieve
        [Parameter(Mandatory,Position=1)]
        [int64]
        $PermissionId,

        # The JiraConnection object to use for the request
        [Parameter(Position=2)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/permissionscheme/$SchemeId/permission/$PermissionId"
        $verb = "DELETE"

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb
    }
}