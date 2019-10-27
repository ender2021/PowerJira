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

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/project/$ProjectIdOrKey/avatar"
        $verb = "PUT"

        $body = New-Object RestMethodJsonBody @{
            id = $AvatarId
        }

        $method = New-Object BodyRestMethod @($functionPath,$verb,$body)
        $method.Invoke($JiraContext)
    }
}