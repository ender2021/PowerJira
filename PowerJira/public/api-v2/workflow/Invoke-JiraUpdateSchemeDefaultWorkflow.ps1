#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-workflowscheme-id-default-put
function Invoke-JiraUpdateSchemeDefaultWorkflow {
    [CmdletBinding()]
    param (
        # The ID of the scheme to update
        [Parameter(Mandatory,Position=0)]
        [int64]
        $SchemeId,

        # The name of the workflow to set as default.  Will be set to the default jira workflow if not specified.
        [Parameter(Position=1)]
        [string]
        $DefaultWorkflow,

        # Set this flag to update a draft if the workflow is currently being used
        [Parameter()]
        [switch]
        $UpdateDraft,

        # The JiraConnection object to use for the request
        [Parameter(Position=2)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/workflowscheme/$SchemeId/default"
        $verb = "PUT"

        $body=@{}
        if($PSBoundParameters.ContainsKey("DefaultWorkflow")){$body.Add("workflow",$DefaultWorkflow)}
        if($PSBoundParameters.ContainsKey("UpdateDraft")){$query.Add("updateDraftIfNeeded",$true)}

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Body $body
    }
}