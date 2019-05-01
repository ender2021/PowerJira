$JiraCommentExpand = @("renderedBody")

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-comment-id-get
function Invoke-JiraGetComment {
    [CmdletBinding()]
    param (
        # The issue Id or Key
        [Parameter(Mandatory,Position=0,ValueFromPipelineByPropertyName)]
        [Alias("IssueId")]
        [string]
        $IssueKey,

        # The ID of the comment to retrieve
        [Parameter(Mandatory,Position=1,ValueFromPipeline,ValueFromPipelineByPropertyName)]
        [int64]
        $Id,

        # Used to expand additional attributes
        [Parameter(Position=2)]
        [ValidateScript({ Compare-StringArraySubset $JiraCommentExpand $_ })]
        [string[]]
        $Expand,

        # The JiraConnection object to use for the request
        [Parameter(Position=3)]
        [hashtable]
        $JiraConnection
    )
    begin {
        $results = @()
    }
    process {
        $functionPath = "/rest/api/2/issue/$IssueKey/comment/$Id"
        $verb = "GET"

        $results += Invoke-JiraRestMethod $JiraConnection $functionPath $verb
    }
    end {
        $results
    }
}