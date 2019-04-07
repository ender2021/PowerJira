#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-applicationrole-key-get
function Invoke-JiraGetApplicationRole {
    [CmdletBinding()]
    param (
        # The Key of the role to retrieve
        [Parameter(Mandatory,Position=0)]
        [string]
        $RoleKey,

        # The JiraConnection object to use for the request
        [Parameter(Position=1)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/applicationrole/$RoleKey"
        $verb = "GET"

        Invoke-JiraRestRequest $JiraConnection $functionPath $verb
    }
}