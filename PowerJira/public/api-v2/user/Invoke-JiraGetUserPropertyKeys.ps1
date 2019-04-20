#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-user-properties-get
function Invoke-JiraGetUserPropertyKeys {
    [CmdletBinding()]
    param (
        # The accountID of the user to retrieve property keys for
        [Parameter(Mandatory,Position=0)]
        [string]
        $User,

        # The JiraConnection object to use for the request
        [Parameter(Position=1)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/user/properties"
        $verb = "GET"

        $query=@{
            accountId = $User
        }

        (Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Query $query).keys
    }
}