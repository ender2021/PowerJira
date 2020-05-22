$JiraUserExpand = @("groups","applicationRoles")

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-user-get
function Invoke-JiraGetUser {
    [CmdletBinding()]
    param (
        # The accountID of the user to retrieve
        [Parameter(Mandatory,Position=0)]
        [string]
        $AccountId,

        # Used to expand additional attributes
        [Parameter(Position=1)]
        [ValidateScript({ Compare-StringArraySubset $JiraUserExpand $_ })]
        [string[]]
        $Expand,

        # The JiraContext object to use for the request
        [Parameter()]
        [object]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/user"
        $verb = "GET"

        $query = New-PACRestMethodQueryParams @{
            accountId = $AccountId
        }
        if($PSBoundParameters.ContainsKey("Expand")){$query.Add("expand",$Expand -join ",")}

        $method = New-PACRestMethod $functionPath $verb $query
        $method.Invoke($JiraContext)
    }
}