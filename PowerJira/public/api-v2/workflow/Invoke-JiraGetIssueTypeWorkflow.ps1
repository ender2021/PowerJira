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

        # The JiraConnection object to use for the request
        [Parameter(Position=2)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/workflowscheme/$SchemeId/issuetype/$IssueTypeId"
        $verb = "GET"

        $query=@{}
        if($PSBoundParameters.ContainsKey("Draft")){$query.Add("returnDraftIfExists",$true)}

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Query $query
    }
}