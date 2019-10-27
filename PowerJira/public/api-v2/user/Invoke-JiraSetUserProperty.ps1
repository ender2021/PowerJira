#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-user-properties-propertyKey-put
function Invoke-JiraSetUserProperty {
    [CmdletBinding()]
    param (
        # The accountID of the user to retrieve property keys for
        [Parameter(Mandatory,Position=0)]
        [string]
        $User,

        # The key of the property to retrieve
        [Parameter(Mandatory,Position=1)]
        [string]
        $PropertyKey,

        # Use this parameter to pass a Json object
        [Parameter(Mandatory,Position=2)]
        [hashtable]
        $PropertyValue,

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/user/properties/$PropertyKey"
        $verb = "PUT"

        $query = [RestMethodQueryParams]::new(@{
            accountId = $User
        })

        $body = [RestMethodJsonBody]::new($PropertyValue)

        $method = [BodyRestMethod]::new($functionPath,$verb,$query,$body)
        $method.Invoke($JiraContext)
    }
}