$JiraPermissionSchemeExpand = @("all","field","group","permissions","projectRole","user")

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-project-projectKeyOrId-permissionscheme-put
function Invoke-JiraSetProjectPermissionScheme {
    [CmdletBinding()]
    param (
        # The ID or key of the project to update
        [Parameter(Mandatory,Position=0)]
        [string]
        $ProjectIdOrKey,

        # The ID of the permission scheme to set
        [Parameter(Mandatory,Position=1)]
        [int64]
        $PermissionScheme,

        # Used to expand additional attributes
        [Parameter(Position=2)]
        [ValidateScript({ Compare-StringArraySubset $JiraPermissionSchemeExpand $_ })]
        [string[]]
        $Expand,
        
        # The JiraConnection object to use for the request
        [Parameter(Position=3)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/project/$ProjectIdOrKey/permissionscheme"
        $verb = "PUT"

        $query = @{}
        if($PSBoundParameters.ContainsKey("Expand")){$query.Add("expand",$Expand -join ",")}

        $body = @{
            id = $PermissionScheme
        }

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Query $query -Body $body
    }
}