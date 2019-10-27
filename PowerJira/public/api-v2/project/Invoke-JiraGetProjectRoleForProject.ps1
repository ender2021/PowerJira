#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-project-projectIdOrKey-role-get
function Invoke-JiraGetProjectRoleForProject {
    [CmdletBinding()]
    param (
        # THe project id or key to retrieve roles for
        [Parameter(Mandatory,Position=0)]
        [string]
        $ProjectIdOrKey,

        # The id of the role to retrieve
        [Parameter(Mandatory,Position=1)]
        [int64]
        $RoleId,

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/project/$ProjectIdOrKey/role/$RoleId"
        $verb = "GET"

        $method = New-Object RestMethod @($functionPath,$verb)
        $method.Invoke($JiraContext)
    }
}