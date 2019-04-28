#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-universal-avatar-type-type-owner-entityId-get
function Invoke-JiraGetAvatars {
    [CmdletBinding()]
    param (
        # The type of avatars to get
        [Parameter(Mandatory,Position=0)]
        [ValidateSet("issuetype","project")]
        [string]
        $Type,

        # The ID of the issuetype or project to retrieve avatars for
        [Parameter(Mandatory,Position=1,ValueFromPipeline,ValueFromPipelineByPropertyName)]
        [string]
        $Id,

        # The JiraConnection object to use for the request
        [Parameter(Position=2)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/universal_avatar/type/$Type/owner/$Id"
        $verb = "GET"

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb
    }
}