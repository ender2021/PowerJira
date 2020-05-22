#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-universal-avatar-type-type-owner-owningObjectId-avatar-id-delete
function Invoke-JiraDeleteAvatar {
    [CmdletBinding()]
    param (
        # The type of avatar to delete
        [Parameter(Mandatory,Position=0)]
        [ValidateSet("issuetype","project")]
        [string]
        $Type,

        # The ID of the issuetype or project to delete an avatar from
        [Parameter(Mandatory,Position=1)]
        [int64]
        $EntityId,

        # The ID of the avatar to delete
        [Parameter(Mandatory,Position=2,ValueFromPipeline,ValueFromPipelineByPropertyName)]
        [int64]
        $Id,

        # The JiraContext object to use for the request
        [Parameter()]
        [object]
        $JiraContext
    )
    begin {
        $results = @()
    }
    process {
        $functionPath = "/rest/api/2/universal_avatar/type/$Type/owner/$EntityId/avatar/$Id"
        $verb = "DELETE"

        $method = New-PACRestMethod $functionPath $verb
        $results += $method.Invoke($JiraContext)
    }
    end {
        $results
    }
}