#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-group-user-post
function Invoke-JiraAddUserToGroup {
    [CmdletBinding()]
    param (
        # Name of the group to add the user to
        [Parameter(Mandatory,Position=0)]
        [string]
        $Name,

        # The accountID of the user to add
        [Parameter(Mandatory,Position=1)]
        [string]
        $User,

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/group/user"
        $verb = "POST"

        $query = New-Object RestMethodQueryParams @{
            groupname = $Name
        }

        $body = New-Object RestMethodJsonBody @{
            accountId = $User
        }

        $method = New-Object BodyRestMethod @($functionPath,$verb,$query,$body)
        $method.Invoke($JiraContext)
    }
}