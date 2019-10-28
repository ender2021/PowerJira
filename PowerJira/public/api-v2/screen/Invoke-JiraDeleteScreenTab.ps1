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

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/screens/$ScreenId/tabs/$TabId"
        $verb = "DELETE"

        $method = New-Object RestMethod @($functionPath,$verb)
        $method.Invoke($JiraContext)
    }
}