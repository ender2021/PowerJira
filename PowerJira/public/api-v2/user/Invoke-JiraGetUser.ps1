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

        # The JiraConnection object to use for the request
        [Parameter(Position=2)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/user"
        $verb = "GET"

        $query = @{
            accountId = $AccountId
        }
        if($PSBoundParameters.ContainsKey("Expand")){$query.Add("expand",$Expand -join ",")}

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Query $query
    }
}