#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-bulk-post
function Invoke-JiraCreateIssueBulk {
    [CmdletBinding()]
    param (
        # An array of hashtables containing instructions for setting fields and updating the issues
        [Parameter(Mandatory,Position=0,ValueFromPipeline)]
        [hashtable[]]
        $Issues,

        # The JiraConnection object to use for the request
        [Parameter(Position=1)]
        [hashtable]
        $JiraConnection
    )
    begin {
        $results = @()
    }
    process {
        $functionPath = "/rest/api/2/issue/bulk"
        $verb = "POST"

        $body=@{issueUpdates=$Issues}

        $results += Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Body $body
    }
    end {
        $results
    }
}