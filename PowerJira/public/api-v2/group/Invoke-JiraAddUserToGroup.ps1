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

        # The JiraConnection object to use for the request
        [Parameter(Position=2)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/group/user"
        $verb = "POST"

        $query = @{
            groupname = $Name
        }

        $body=@{
            accountId = $User
        }

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Query $query -Body $body
    }
}