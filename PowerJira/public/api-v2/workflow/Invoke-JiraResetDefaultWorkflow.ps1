#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-workflowscheme-id-default-delete
function Invoke-JiraResetDefaultWorkflow {
    [CmdletBinding()]
    param (
        # The ID of the scheme to update
        [Parameter(Mandatory,Position=0)]
        [int64]
        $SchemeId,

        # The JiraConnection object to use for the request
        [Parameter(Position=1)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/workflowscheme/$SchemeId/default"
        $verb = "DELETE"

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb
    }
}