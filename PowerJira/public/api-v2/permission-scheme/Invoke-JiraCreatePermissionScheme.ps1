$JiraPermissionSchemeExpand = @("all","field","group","permissions","projectRole","user")

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-permissionscheme-post
function Invoke-JiraCreatePermissionScheme {
    [CmdletBinding()]
    param (
        # A name for the scheme
        [Parameter(Mandatory,Position=0)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Name,

        # A description of the scheme
        [Parameter(Position=1)]
        [string]
        $Description,

        # A list of permission grants for the scheme.  Use New-JiraPermissionGrant
        [Parameter(Position=2)]
        [hashtable[]]
        $Permissions,

        # Used to expand additional attributes
        [Parameter(Position=3)]
        [ValidateScript({ Compare-StringArraySubset $JiraPermissionSchemeExpand $_ })]
        [string[]]
        $Expand,

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/permissionscheme"
        $verb = "POST"

        $query = New-Object RestMethodQueryParams
        if($PSBoundParameters.ContainsKey("Expand")){$query.Add("expand",$Expand -join ",")}

        $body = New-Object RestMethodJsonBody @{
            name = $Name
        }
        if($PSBoundParameters.ContainsKey("Description")){$body.Add("description",$Description)}
        if($PSBoundParameters.ContainsKey("Permissions")){$body.Add("permissions",$Permissions)}

        $method = New-Object BodyRestMethod @($functionPath,$verb,$query,$body)
        $method.Invoke($JiraContext)
    }
}