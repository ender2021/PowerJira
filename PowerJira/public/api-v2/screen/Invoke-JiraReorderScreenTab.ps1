#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-screens-screenId-tabs-tabId-move-pos-post
function Invoke-JiraReorderScreenTab {
    [CmdletBinding()]
    param (
        # The ID of the screen
        [Parameter(Mandatory,Position=0)]
        [int64]
        $ScreenId,

        # The ID of the tab
        [Parameter(Mandatory,Position=1)]
        [int64]
        $TabId,

        # The 0-based position to move the tab to
        [Parameter(Mandatory,Position=2)]
        [int64]
        $Position,

        # The JiraConnection object to use for the request
        [Parameter(Position=3)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/screens/$ScreenId/tabs/$TabId/move/$Position"
        $verb = "POST"

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb
    }
}