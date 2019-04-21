$JiraPermissionSchemeExpand = @("all","field","group","permissions","projectRole","user")

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-permissionscheme-put
function Invoke-JiraUpdatePermissionScheme {
    [CmdletBinding()]
    param (
        # The id of the scheme to update
        [Parameter(Mandatory,Position=0)]
        [int64]
        $SchemeId,

        # A name for the scheme
        [Parameter(Mandatory,Position=1)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Name,

        # A description of the scheme
        [Parameter(Position=2)]
        [string]
        $Description,

        # A list of permission grants for the scheme.  Use New-JiraPermissionGrant
        [Parameter(Position=3)]
        [hashtable[]]
        $Permissions,

        # Used to expand additional attributes
        [Parameter(Position=4)]
        [ValidateScript({ Compare-StringArraySubset $JiraPermissionSchemeExpand $_ })]
        [string[]]
        $Expand,

        # The JiraConnection object to use for the request
        [Parameter(Position=5)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/permissionscheme/$SchemeId"
        $verb = "PUT"

        $query=@{}
        if($PSBoundParameters.ContainsKey("Expand")){$query.Add("expand",$Expand -join ",")}

        $body = @{
            name = $Name
        }
        if($PSBoundParameters.ContainsKey("Description")){$body.Add("description",$Description)}
        if($PSBoundParameters.ContainsKey("Permissions")){$body.Add("permissions",$Permissions)}

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Query $query -Body $body
    }
}