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

        # The JiraConnection object to use for the request
        [Parameter(Position=3)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/screens/$ScreenId/tabs/$TabId/fields/$FieldId"
        $verb = "DELETE"

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb
    }
}