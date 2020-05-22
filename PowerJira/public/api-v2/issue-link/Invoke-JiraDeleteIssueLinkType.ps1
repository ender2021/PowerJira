#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issueLinkType-issueLinkTypeId-delete
function Invoke-JiraDeleteIssueLinkType {
    [CmdletBinding()]
    param (
        # The Id of the Issue Link Type
        [Parameter(Mandatory,Position=0)]
        [string]
        $LinkTypeId,

        # The JiraContext object to use for the request
        [Parameter()]
        [object]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/issueLinkType/$LinkTypeId"
        $verb = "DELETE"

        $method = New-PACRestMethod $functionPath $verb
        $method.Invoke($JiraContext)
    }
}