#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-bulk-post
function Invoke-JiraCreateIssueBulk {
    [CmdletBinding()]
    param (
        # An array of hashtables containing instructions for setting fields and updating the issues
        [Parameter(Mandatory,Position=0,ValueFromPipeline)]
        [hashtable[]]
        $Issues,

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    begin {
        $results = @()
    }
    process {
        $functionPath = "/rest/api/2/issue/bulk"
        $verb = "POST"

        $body = [RestMethodJsonBody]::new(@{issueUpdates=$Issues})

        $method = [BodyRestMethod]::new($functionPath,$verb,$body)
        $results += $method.Invoke($JiraContext)
    }
    end {
        $results
    }
}