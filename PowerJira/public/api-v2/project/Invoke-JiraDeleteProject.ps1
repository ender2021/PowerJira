#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-project-projectIdOrKey-delete
function Invoke-JiraDeleteProject {
    [CmdletBinding()]
    param (
        # The ID or key of the project to delete
        [Parameter(Mandatory,Position=0)]
        [string]
        $ProjectIdOrKey,

        # The JiraConnection object to use for the request
        [Parameter(Position=1)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/project/$ProjectIdOrKey"
        $verb = "DELETE"

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb
    }
}