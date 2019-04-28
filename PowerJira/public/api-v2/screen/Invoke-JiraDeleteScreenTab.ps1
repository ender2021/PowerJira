#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-screens-screenId-tabs-delete
function Invoke-JiraDeleteScreenTab {
    [CmdletBinding()]
    param (
        # The ID of the screen to update
        [Parameter(Mandatory,Position=0)]
        [int64]
        $ScreenId,

        # The ID of the tab to update
        [Parameter(Mandatory,Position=1)]
        [int64]
        $TabId,

        # The JiraConnection object to use for the request
        [Parameter(Position=2)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/screens/$ScreenId/tabs/$TabId"
        $verb = "DELETE"

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb
    }
}