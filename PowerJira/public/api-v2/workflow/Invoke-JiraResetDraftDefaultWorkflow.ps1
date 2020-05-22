#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-workflowscheme-id-draft-default-delete
function Invoke-JiraResetDraftDefaultWorkflow {
    [CmdletBinding()]
    param (
        # The ID of the scheme to update
        [Parameter(Mandatory,Position=0)]
        [int64]
        $SchemeId,

        # The JiraContext object to use for the request
        [Parameter()]
        [object]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/workflowscheme/$SchemeId/draft/default"
        $verb = "DELETE"

        $method = New-PACRestMethod $functionPath $verb
        $method.Invoke($JiraContext)
    }
}