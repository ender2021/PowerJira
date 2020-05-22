#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-workflowscheme-id-get
function Invoke-JiraGetWorkflowScheme {
    [CmdletBinding()]
    param (
        # The id of the scheme to retrieve
        [Parameter(Mandatory,Position=0)]
        [int64]
        $SchemeId,

        # The JiraContext object to use for the request
        [Parameter()]
        [object]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/workflowscheme/$SchemeId"
        $verb = "GET"

        $method = New-PACRestMethod $functionPath $verb
        $method.Invoke($JiraContext)
    }
}