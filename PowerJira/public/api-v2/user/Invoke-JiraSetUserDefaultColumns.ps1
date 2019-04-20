#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-user-columns-put
function Invoke-JiraSetUserDefaultColumns {
    [CmdletBinding()]
    param (
        # An array of field names to display as columns
        [Parameter(Mandatory,Position=0)]
        [ValidateNotNullOrEmpty()]
        [string[]]
        $Columns,

        # The accountID of the user to set default columns for
        [Parameter(Position=1)]
        [string]
        $User,

        # The JiraConnection object to use for the request
        [Parameter(Position=2)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/user/columns"
        $verb = "PUT"

        $query=@{}
        if($PSBoundParameters.ContainsKey("User")){$query.Add("accountId",$User)}

        $body = @{
            columns = $Columns
        }

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Query $query -Body $body
    }
}