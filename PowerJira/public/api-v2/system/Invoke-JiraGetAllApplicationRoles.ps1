#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-applicationrole-get
function Invoke-JiraGetAllApplicationRoles {
    [CmdletBinding()]
    param (
        # The JiraConnection object to use for the request
        [Parameter()]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/applicationrole"
        $verb = "GET"

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod $verb
    }
}