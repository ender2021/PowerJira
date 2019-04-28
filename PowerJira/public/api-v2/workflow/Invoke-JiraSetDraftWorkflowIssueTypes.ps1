#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-workflowscheme-id-draft-workflow-put
function Invoke-JiraSetDraftWorkflowIssueTypes {
    [CmdletBinding(DefaultParameterSetName="Named")]
    param (
        # The id of the scheme
        [Parameter(Mandatory,Position=0)]
        [int64]
        $SchemeId,

        # The workflow to set issue types for
        [Parameter(Mandatory,Position=1,ParameterSetName="Named")]
        [string]
        $WorkflowName,

        # Set this flag to 
        [Parameter(Mandatory,Position=1,ParameterSetName="Default")]
        [switch]
        $Default,

        # The issue types to assign to the workflow
        [Parameter(Mandatory,Position=2)]
        [int64[]]
        $IssueTypeIds,

        # The JiraConnection object to use for the request
        [Parameter(Position=3)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/workflowscheme/$SchemeId/draft/workflow"
        $verb = "PUT"

        $query=@{}
        if($PSBoundParameters.ContainsKey("WorkflowName")){$query.Add("workflowName",$WorkflowName)}

        $body = @{
            issueTypes = $IssueTypeIds
        }
        if($PSBoundParameters.ContainsKey("WorkflowName")){$body.Add("workflow",$WorkflowName)}
        if($PSBoundParameters.ContainsKey("Default")){$body.Add("defaultMapping",$true)}

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Query $query -Body $body
    }
}