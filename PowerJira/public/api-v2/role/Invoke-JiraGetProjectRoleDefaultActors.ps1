#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-role-id-actors-get
function Invoke-JiraGetProjectRoleDefaultActors {
    [CmdletBinding()]
    param (
        # The ID of the project role to retrieve
        [Parameter(Mandatory,Position=0)]
        [int64]
        $ProjectRoleId,
        
        # The JiraConnection object to use for the request
        [Parameter(Position=1)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/role/$ProjectRoleId/actors"

        (Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "GET").actors
    }
}