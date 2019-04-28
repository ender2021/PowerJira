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

        # The JiraConnection object to use for the request
        [Parameter(Position=3)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/universal_avatar/type/$Type/owner/$EntityId/avatar/$Id"
        $verb = "DELETE"

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb
    }
}