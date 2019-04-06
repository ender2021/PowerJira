#   https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-attachment-id-get
function Invoke-JiraGetAttachmentMetadata {
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
        $verb = "GET"

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod $verb
    }
}