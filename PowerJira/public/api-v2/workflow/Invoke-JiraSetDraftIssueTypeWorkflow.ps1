#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-workflowscheme-id-draft-issuetype-issueType-put
function Invoke-JiraSetDraftIssueTypeWorkflow {
    [CmdletBinding()]
    param (
        # The id of the scheme
        [Parameter(Mandatory,Position=0)]
        [int64]
        $SchemeId,

        # The issue type to assign to the workflow
        [Parameter(Mandatory,Position=1)]
        [int64]
        $IssueTypeId,

        # The workflow to set the issue type to
        [Parameter(Mandatory,Position=2)]
        [string]
        $WorkflowName,

        # The JiraConnection object to use for the request
        [Parameter(Position=3)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/workflowscheme/$SchemeId/draft/issuetype/$IssueTypeId"
        $verb = "PUT"

        $body = @{
            issueType = $IssueTypeId
            workflow = $WorkflowName
        }

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Body $body
    }
}