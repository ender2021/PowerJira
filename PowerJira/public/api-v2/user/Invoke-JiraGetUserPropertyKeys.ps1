#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-user-properties-get
function Invoke-JiraGetUserPropertyKeys {
    [CmdletBinding()]
    param (
        # The accountID of the user to retrieve property keys for
        [Parameter(Mandatory,Position=0)]
        [string]
        $User,

        # The JiraContext object to use for the request
        [Parameter()]
        [object]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/user/properties"
        $verb = "GET"

        $query = New-PACRestMethodQueryParams @{
            accountId = $User
        }

        $method = New-PACRestMethod $functionPath $verb $query
        $method.Invoke($JiraContext).keys
    }
}