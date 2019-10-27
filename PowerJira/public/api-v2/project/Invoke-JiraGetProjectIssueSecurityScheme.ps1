#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-project-projectKeyOrId-issuesecuritylevelscheme-get
function Invoke-JiraGetProjectIssueSecurityScheme {
    [CmdletBinding()]
    param (
        # The project Id or Key
        [Parameter(Mandatory,Position=0)]
        [string]
        $ProjectIdOrKey,

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/project/$ProjectIdOrKey/issuesecuritylevelscheme"
        $verb = "GET"

        $method = New-Object RestMethod @($functionPath,$verb)
        $method.Invoke($JiraContext)
    }
}