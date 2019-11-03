#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-role-id-put
function Invoke-JiraUpdateProjectRoleFull {
    [CmdletBinding()]
    param (
        # The ID of the project role to update
        [Parameter(Mandatory,Position=0)]
        [int64]
        $ProjectRoleId,

        # The name of the role to create
        [Parameter(Mandatory,Position=1)]
        [ValidateLength(1,255)]
        [string]
        $Name,

        # Option role description
        [Parameter(Mandatory,Position=2)]
        [string]
        $Description,
        
        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/role/$ProjectRoleId"
        $verb = "PUT"

        $body = New-Object RestMethodJsonBody @{
            name = $Name
            description = $Description
        }

        $method = New-Object BodyRestMethod @($functionPath,$verb,$body)
        $method.Invoke($JiraContext)
    }
}