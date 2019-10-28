#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-screens-screenId-tabs-tabId-fields-delete
function Invoke-JiraRemoveScreenTabField {
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

        # The field to add
        [Parameter(Mandatory,Position=2)]
        [string]
        $FieldId,

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/screens/$ScreenId/tabs/$TabId/fields/$FieldId"
        $verb = "DELETE"

        $method = New-Object RestMethod @($functionPath,$verb)
        $method.Invoke($JiraContext)
    }
}