#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-workflowscheme-id-issuetype-issueType-delete
function Invoke-JiraDeleteIssueTypeWorkflow {
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

        # Set this flag to update a draft if the workflow is currently being used
        [Parameter()]
        [switch]
        $UpdateDraft,

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/workflowscheme/$SchemeId/issuetype/$IssueTypeId"
        $verb = "DELETE"

        $query = [RestMethodQueryParams]::new()
        if($PSBoundParameters.ContainsKey("UpdateDraft")){$query.Add("updateDraftIfNeeded",$true)}

        $method = [RestMethod]::new($functionPath,$verb,$query)
        $method.Invoke($JiraContext)
    }
}