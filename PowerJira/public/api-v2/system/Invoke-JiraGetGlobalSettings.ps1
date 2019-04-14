#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-configuration-get
function Invoke-JiraGetGlobalSettings {
    [CmdletBinding()]
    param (
        # The JiraConnection object to use for the request
        [Parameter(Position=0)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/configuration"
        $verb = "GET"

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb
    }
}