$JiraPermissionSchemeExpand = @("all","field","group","permissions","projectRole","user")

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-permissionscheme-get
function Invoke-JiraGetAllPermissionSchemes {
    [CmdletBinding()]
    param (
        # Used to expand additional attributes
        [Parameter(Position=0)]
        [ValidateScript({ Compare-StringArraySubset $JiraPermissionSchemeExpand $_ })]
        [string[]]
        $Expand,

        # The JiraConnection object to use for the request
        [Parameter(Position=1)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/permissionscheme"
        $verb = "GET"

        $query=@{}
        if($PSBoundParameters.ContainsKey("Expand")){$query.Add("expand",$Expand -join ",")}

        (Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Query $query).permissionSchemes
    }
}