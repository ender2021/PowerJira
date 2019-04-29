#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-attachment-id-get
function Invoke-JiraGetAttachmentMetadata {
    [CmdletBinding()]
    param (
        # THe ID of the attachment to get metadata for
        [Parameter(Mandatory,Position=0,ValueFromPipeline,ValueFromPipelineByPropertyName)]
        [int64]
        $Id,

        # The JiraConnection object to use for the request
        [Parameter(Position=1)]
        [hashtable]
        $JiraConnection
    )
    begin {
        $results = @()
    }
    process {
        $functionPath = "/rest/api/2/attachment/$Id"
        $verb = "GET"

        $results += Invoke-JiraRestMethod $JiraConnection $functionPath $verb
    }
    end {
        $results
    }
}