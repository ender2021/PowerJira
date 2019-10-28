#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-role-id-delete
function Invoke-JiraDeleteProjectRole {
    [CmdletBinding()]
    param (
        # The ID of the project role to retrieve
        [Parameter(Mandatory,Position=0)]
        [int64]
        $ProjectRoleId,

        # The id of the role to swap with this one in projects
        [Parameter(Position=1)]
        [int64]
        $SwapRoleId,
        
        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/role/$ProjectRoleId"
        $verb = "DELETE"

        $query = New-Object RestMethodQueryParams
        if($PSBoundParameters.ContainsKey("SwapRoleId")){$query.Add("swap",$SwapRoleId)}

        $method = New-Object RestMethod @($functionPath,$verb,$query)
        $method.Invoke($JiraContext)
    }
}