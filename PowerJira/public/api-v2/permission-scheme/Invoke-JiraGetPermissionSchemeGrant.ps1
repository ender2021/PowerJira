$JiraPermissionSchemeExpand = @("all","field","group","permissions","projectRole","user")

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-permissionscheme-schemeId-permission-permissionId-get
function Invoke-JiraGetPermissionSchemeGrant {
    [CmdletBinding()]
    param (
        # The ID of the scheme to retrieve
        [Parameter(Mandatory,Position=0)]
        [int64]
        $SchemeId,

        # The id of the permission to retrieve
        [Parameter(Mandatory,Position=1)]
        [int64]
        $PermissionId,

        # Used to expand additional attributes
        [Parameter(Position=2)]
        [ValidateScript({ Compare-StringArraySubset $JiraPermissionSchemeExpand $_ })]
        [string[]]
        $Expand,

        # The JiraContext object to use for the request
        [Parameter()]
        [object]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/permissionscheme/$SchemeId/permission/$PermissionId"
        $verb = "GET"

        $query = New-PACRestMethodQueryParams
        if($PSBoundParameters.ContainsKey("Expand")){$query.Add("expand",$Expand -join ",")}

        $method = New-PACRestMethod $functionPath $verb $query
        $method.Invoke($JiraContext)
    }
}