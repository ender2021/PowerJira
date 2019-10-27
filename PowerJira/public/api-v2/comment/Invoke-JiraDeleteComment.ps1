#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-comment-id-delete
function Invoke-JiraDeleteComment {
    [CmdletBinding()]
    param (
        # The issue Id or Key
        [Parameter(Mandatory,Position=0,ValueFromPipelineByPropertyName)]
        [Alias("IssueId")]
        [string]
        $IssueKey,    

        # The ID of the comment to retrieve
        [Parameter(Mandatory,Position=1,ValueFromPipeline,ValueFromPipelineByPropertyName)]
        [int32]
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
        $functionPath = "/rest/api/2/issue/$IssueKey/comment/$Id"
        $verb = "DELETE"

        $method = [RestMethod]::new($functionPath,$verb)
        $results += $method.Invoke($JiraContext)
    }
    end {
        #$results
    }
}