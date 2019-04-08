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
        
        # The JiraConnection object to use for the request
        [Parameter(Position=2)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/role/$ProjectRoleId"
        $verb = "DELETE"

        $query = @{}
        if($PSBoundParameters.ContainsKey("SwapRoleId")){$query.Add("swap",$SwapRoleId)}

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Query $query
    }
}