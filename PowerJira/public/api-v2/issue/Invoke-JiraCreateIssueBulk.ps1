#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-bulk-post
function Invoke-JiraCreateIssueBulk {
    [CmdletBinding()]
    param (
        # An array of hashtables containing instructions for setting fields and updating the issues
        [Parameter(Mandatory,Position=0)]
        [hashtable[]]
        $Issues,

        # The JiraConnection object to use for the request
        [Parameter(Position=1)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issue/bulk"
        $verb = "POST"

        $body=@{issueUpdates=$Issues}

        Invoke-JiraRestRequest $JiraConnection $functionPath $verb -Body $body
    }
}