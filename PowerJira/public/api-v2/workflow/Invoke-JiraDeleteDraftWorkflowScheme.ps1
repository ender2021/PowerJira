#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-workflowscheme-id-draft-delete
function Invoke-JiraDeleteDraftWorkflowScheme {
    [CmdletBinding()]
    param (
        # The ID of the scheme draft to delete
        [Parameter(Mandatory,Position=0)]
        [int64]
        $SchemeId,

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/workflowscheme/$SchemeId/draft"
        $verb = "DELETE"

        $method = New-Object RestMethod @($functionPath,$verb)
        $method.Invoke($JiraContext)
    }
}