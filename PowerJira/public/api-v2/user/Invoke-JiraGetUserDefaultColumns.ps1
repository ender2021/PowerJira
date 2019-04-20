#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-user-columns-get
function Invoke-JiraGetUserDefaultColumns {
    [CmdletBinding()]
    param (
        # The accountID of the user to retrieve default columns for
        [Parameter(Position=0)]
        [string]
        $User,

        # The JiraConnection object to use for the request
        [Parameter(Position=1)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/user/columns"
        $verb = "GET"

        $query=@{}
        if($PSBoundParameters.ContainsKey("User")){$query.Add("accountId",$User)}

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Query $query
    }
}