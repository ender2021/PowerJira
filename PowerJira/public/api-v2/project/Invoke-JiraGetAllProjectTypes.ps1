#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-project-type-get
function Invoke-JiraGetAllProjectTypes {
    [CmdletBinding()]
    param (
        # The JiraConnection object to use for the request
        [Parameter(Position=0)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/project/type"
        $verb = "GET"

        Invoke-JiraRestRequest $JiraConnection $functionPath $verb
    }
}