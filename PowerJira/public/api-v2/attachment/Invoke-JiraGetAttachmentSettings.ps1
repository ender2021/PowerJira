#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-attachment-meta-get
function Invoke-JiraGetAttachmentSettings {
    [CmdletBinding()]
    param (
        # The JiraContext object to use for the request
        [Parameter()]
        [object]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/attachment/meta"
        $verb = "GET"

        $method = New-PACRestMethod $functionPath $verb
        $method.Invoke($JiraContext)
    }
}