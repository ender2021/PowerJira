#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-workflowscheme-id-draft-issuetype-issueType-get
function Invoke-JiraGetDraftIssueTypeWorkflow {
    [CmdletBinding()]
    param (
        # The id of the scheme
        [Parameter(Mandatory,Position=0)]
        [int64]
        $SchemeId,

        # The id of the issue type
        [Parameter(Mandatory,Position=1)]
        [int64]
        $IssueTypeId,

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/workflowscheme/$SchemeId/draft/issuetype/$IssueTypeId"
        $verb = "GET"

        $method = [RestMethod]::new($functionPath,$verb)
        $method.Invoke($JiraContext)
    }
}