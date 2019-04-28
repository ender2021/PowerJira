#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-workflowscheme-id-default-get
function Invoke-JiraGetDefaultWorkflow {
    [CmdletBinding()]
    param (
        # The id of the scheme to retrieve the default workflow for
        [Parameter(Mandatory,Position=0)]
        [int64]
        $SchemeId,

        # Set this flag to return the default workflow of the scheme's draft (instead of the published version)
        [Parameter()]
        [switch]
        $Draft,

        # The JiraConnection object to use for the request
        [Parameter(Position=1)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/workflowscheme/$SchemeId/default"
        $verb = "GET"

        $query=@{}
        if($PSBoundParameters.ContainsKey("Draft")){$query.Add("returnDraftIfExists",$true)}

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Query $query
    }
}