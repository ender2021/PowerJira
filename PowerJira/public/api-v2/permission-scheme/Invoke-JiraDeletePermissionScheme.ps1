#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-permissionscheme-schemeId-delete
function Invoke-JiraDeletePermissionScheme {
    [CmdletBinding()]
    param (
        # The id of the scheme to delete
        [Parameter(Mandatory,Position=0)]
        [int64]
        $SchemeId,

        # The JiraConnection object to use for the request
        [Parameter(Position=1)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/permissionscheme/$SchemeId"
        $verb = "DELETE"

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb
    }
}