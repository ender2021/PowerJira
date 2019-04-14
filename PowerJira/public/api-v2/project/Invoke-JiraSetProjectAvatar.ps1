#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-project-projectIdOrKey-avatar-put
function Invoke-JiraSetProjectAvatar {
    [CmdletBinding()]
    param (
        # The project Id or Key
        [Parameter(Mandatory,Position=0)]
        [string]
        $ProjectIdOrKey,

        # The ID of the avatar to set
        [Parameter(Mandatory,Position=1)]
        [string]
        $AvatarId,

        # The JiraConnection object to use for the request
        [Parameter(Position=2)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/project/$ProjectIdOrKey/avatar"
        $verb = "PUT"

        $body = @{
            id = $AvatarId
        }

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Body $body
    }
}