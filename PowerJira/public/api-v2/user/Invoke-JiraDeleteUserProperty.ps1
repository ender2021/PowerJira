#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-user-properties-propertyKey-delete
function Invoke-JiraDeleteUserProperty {
    [CmdletBinding()]
    param (
        # The accountID of the user to delete a property for
        [Parameter(Mandatory,Position=0)]
        [string]
        $User,

        # The key of the property to delete
        [Parameter(Mandatory,Position=1)]
        [string]
        $PropertyKey,

        # The JiraContext object to use for the request
        [Parameter()]
        [object]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/user/properties/$PropertyKey"
        $verb = "DELETE"

        $query = New-PACRestMethodQueryParams @{
            accountId = $User
        }

        $method = New-PACRestMethod $functionPath $verb $query
        $method.Invoke($JiraContext)
    }
}