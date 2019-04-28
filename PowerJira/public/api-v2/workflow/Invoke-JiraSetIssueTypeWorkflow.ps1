#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-workflowscheme-id-issuetype-issueType-put
function Invoke-JiraSetIssueTypeWorkflow {
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

        # Set this flag to update a draft if the workflow is currently being used
        [Parameter()]
        [switch]
        $UpdateDraft,

        # The JiraConnection object to use for the request
        [Parameter(Position=3)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/workflowscheme/$SchemeId/issuetype/$IssueTypeId"
        $verb = "PUT"

        $body = @{
            issueType = $IssueTypeId
            workflow = $WorkflowName
        }
        if($PSBoundParameters.ContainsKey("UpdateDraft")){$body.Add("updateDraftIfNeeded",$true)}

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Body $body
    }
}