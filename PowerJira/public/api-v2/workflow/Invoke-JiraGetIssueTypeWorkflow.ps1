#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-workflowscheme-id-issuetype-issueType-get
function Invoke-JiraGetIssueTypeWorkflow {
    [CmdletBinding()]
    param (
        # The id of the scheme
        [Parameter(Mandatory,Position=0)]
        [int64]
        $SchemeId,

        # The id of the issue type
        [Parameter(Mandatory,Position=1)]
        [int64]
        $IssueTypeId,

        # Set this flag to return the default workflow of the scheme's draft (instead of the published version)
        [Parameter()]
        [switch]
        $Draft,

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/workflowscheme/$SchemeId/issuetype/$IssueTypeId"
        $verb = "GET"

        $query = [RestMethodQueryParams]::new()
        if($PSBoundParameters.ContainsKey("Draft")){$query.Add("returnDraftIfExists",$true)}

        $method = [RestMethod]::new($functionPath,$verb,$query)
        $method.Invoke($JiraContext)
    }
}