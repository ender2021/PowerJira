#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-workflowscheme-post
function Invoke-JiraCreateWorkflowScheme {
    [CmdletBinding()]
    param (
        # The name of the new workflow
        [Parameter(Mandatory,Position=0)]
        [ValidateNotNullOrEmpty()]
        [ValidateLength(1,255)]
        [string]
        $Name,

        # The description of the new workflow
        [Parameter(Position=1)]
        [string]
        $Description,

        # The name of the workflow to set as default.  Will be set to the default jira workflow if not specified.
        [Parameter(Position=2)]
        [string]
        $DefaultWorkflow,

        # An array of issue type workflow mappings (use New-JiraIssueTypeWorkflowMapping for objects to add to the array)
        [Parameter(Position=3)]
        [ValidateScript({ Test-MaxOccurrence ($_ | ForEach-Object { $_.type }) 1 })]
        [hashtable[]]
        $IssueTypeMappings,

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/workflowscheme"
        $verb = "POST"

        $body = [RestMethodJsonBody]::new(@{
            name = $Name
        })
        if($PSBoundParameters.ContainsKey("Description")){$body.Add("description",$Description)}
        if($PSBoundParameters.ContainsKey("DefaultWorkflow")){$body.Add("defaultWorkflow",$DefaultWorkflow)}
        if($PSBoundParameters.ContainsKey("IssueTypeMappings")){$body.Add("issueTypeMappings",($IssueTypeMappings | ForEach-Object {$h=@{}} {$type=$_.type;$h.Add("$type",$_.workflow)} {$h}))}

        $method = [BodyRestMethod]::new($functionPath,$verb,$body)
        $method.Invoke($JiraContext)
    }
}