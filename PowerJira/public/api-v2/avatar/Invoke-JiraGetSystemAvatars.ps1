#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-avatar-type-system-get
function Invoke-JiraGetSystemAvatars {
    [CmdletBinding()]
    param (
        # The type of avatars to get
        [Parameter(Mandatory,Position=0,ValueFromPipeline,ValueFromPipelineByPropertyName)]
        [ValidateSet("issuetype","project","user")]
        [string]
        $Type,

        # The JiraConnection object to use for the request
        [Parameter(Position=1)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/avatar/$Type/system"
        $verb = "GET"

        (Invoke-JiraRestMethod $JiraConnection $functionPath $verb).system
    }
}