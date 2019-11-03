#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-workflowscheme-id-draft-put
function Invoke-JiraUpdateDraftWorkflowScheme {
    [CmdletBinding()]
    param (
        # The ID of the scheme to update
        [Parameter(Mandatory,Position=0)]
        [int64]
        $SchemeId,

        # The name of the new workflow
        [Parameter(Position=1)]
        [ValidateNotNullOrEmpty()]
        [ValidateLength(1,255)]
        [string]
        $Name,

        # The description of the new workflow
        [Parameter(Position=2)]
        [string]
        $Description,

        # The name of the workflow to set as default.  Will be set to the default jira workflow if not specified.
        [Parameter(Position=3)]
        [string]
        $DefaultWorkflow,

        # An array of issue type workflow mappings (use New-JiraIssueTypeWorkflowMapping for objects to add to the array)
        [Parameter(Position=4)]
        [ValidateScript({ Test-MaxOccurrence ($_ | ForEach-Object { $_.type }) 1 })]
        [hashtable[]]
        $IssueTypeMappings,

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/workflowscheme/$SchemeId/draft"
        $verb = "PUT"

        $body = New-Object RestMethodJsonBody
        if($PSBoundParameters.ContainsKey("Name")){$body.Add("name",$Name)}
        if($PSBoundParameters.ContainsKey("Description")){$body.Add("description",$Description)}
        if($PSBoundParameters.ContainsKey("DefaultWorkflow")){$body.Add("defaultWorkflow",$DefaultWorkflow)}
        if($PSBoundParameters.ContainsKey("UpdateDraft")){$body.Add("updateDraftIfNeeded",$true)}

        $method = New-Object BodyRestMethod @($functionPath,$verb,$body)
        $method.Invoke($JiraContext)
    }
}