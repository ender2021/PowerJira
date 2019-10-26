#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-attachment-id-get
function Invoke-JiraGetAttachmentMetadata {
    [CmdletBinding()]
    param (
        # THe ID of the attachment to get metadata for
        [Parameter(Mandatory,Position=0,ValueFromPipeline,ValueFromPipelineByPropertyName)]
        [int64]
        $Id,

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    begin {
        $results = @()
    }
    process {
        $functionPath = "/rest/api/2/attachment/$Id"
        $verb = "GET"

        $method = [RestMethod]::new($functionPath,$verb)
        $results += $method.Invoke($JiraContext)
    }
    end {
        $results
    }
}