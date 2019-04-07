#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-attachment-id-delete
function Invoke-JiraDeleteAttachment {
    [CmdletBinding()]
    param (
        # THe ID of the attachment to delete
        [Parameter(Mandatory,Position=0)]
        [string]
        $AttachmentId,

        # The JiraConnection object to use for the request
        [Parameter(Position=1)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/attachment/$AttachmentId"
        $verb = "DELETE"

        Invoke-JiraRestRequest $JiraConnection $functionPath $verb
    }
}