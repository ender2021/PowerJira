#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-workflowscheme-id-draft-default-put
function Invoke-JiraUpdateDraftDefaultWorkflow {
    [CmdletBinding()]
    param (
        # The ID of the scheme to update
        [Parameter(Mandatory,Position=0)]
        [int64]
        $SchemeId,

        # The name of the workflow to set as default.  Will be set to the default jira workflow if not specified.
        [Parameter(Mandatory,Position=1)]
        [string]
        $DefaultWorkflow,

        # The JiraConnection object to use for the request
        [Parameter(Position=2)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/workflowscheme/$SchemeId/draft/default"
        $verb = "PUT"

        $body=@{
            workflow = $DefaultWorkflow
        }

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Body $body
    }
}