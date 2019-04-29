#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-attachment-id-delete
function Invoke-JiraDeleteAttachment {
    [CmdletBinding()]
    param (
        # THe ID of the attachment to delete
        [Parameter(Mandatory,Position=0,ValueFromPipeline,ValueFromPipelineByPropertyName)]
        [int64]
        $id,

        # The JiraConnection object to use for the request
        [Parameter(Position=1)]
        [hashtable]
        $JiraConnection
    )
    begin {
        $results = @()
    }
    process {
        $functionPath = "/rest/api/2/attachment/$id"
        $verb = "DELETE"

        $results += Invoke-JiraRestMethod $JiraConnection $functionPath $verb
    }
    end {
        #$results
    }
}