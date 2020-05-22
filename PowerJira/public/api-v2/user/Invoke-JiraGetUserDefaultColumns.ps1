#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-user-columns-get
function Invoke-JiraGetUserDefaultColumns {
    [CmdletBinding()]
    param (
        # The accountID of the user to retrieve default columns for
        [Parameter(Position=0)]
        [string]
        $User,

        # The JiraContext object to use for the request
        [Parameter()]
        [object]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/user/columns"
        $verb = "GET"

        $query = New-PACRestMethodQueryParams
        if($PSBoundParameters.ContainsKey("User")){$query.Add("accountId",$User)}

        $method = New-PACRestMethod $functionPath $verb $query
        $method.Invoke($JiraContext)
    }
}