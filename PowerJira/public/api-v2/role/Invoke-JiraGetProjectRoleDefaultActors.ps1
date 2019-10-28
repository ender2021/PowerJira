#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-role-id-actors-get
function Invoke-JiraGetProjectRoleDefaultActors {
    [CmdletBinding()]
    param (
        # The ID of the project role to retrieve
        [Parameter(Mandatory,Position=0)]
        [int64]
        $ProjectRoleId,
        
        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/role/$ProjectRoleId/actors"
        $verb = "GET"

        $method = New-Object RestMethod @($functionPath,$verb)
        $method.Invoke($JiraContext).actors
    }
}