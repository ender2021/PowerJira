#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-changelog-get
function Invoke-JiraGetIssueChangelogs {
    [CmdletBinding()]
    param (
        # The issue Id or Key
        [Parameter(Mandatory,Position=0)]
        [string]
        $IssueIdOrKey,

        # The index of the first item to return in the page of results (page offset). The base index is 0.
        [Parameter(Position=1)]
        [int32]
        $StartAt=0,

        # The maximum number of items to return per page. The default is 100 and the maximum is 100.
        [Parameter(Position=2)]
        [ValidateRange(1,100)]
        [int32]
        $MaxResults=100,

        # The JiraConnection object to use for the request
        [Parameter(Position=3)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issue/$IssueIdOrKey/changelog"
        $verb = "GET"

        $query=@{
            startAt = $StartAt
            maxResults = $MaxResults
        }

        Invoke-JiraRestRequest $JiraConnection $functionPath $verb -Query $query
    }
}