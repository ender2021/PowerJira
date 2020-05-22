#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-screens-screenId-tabs-tabId-fields-id-move-post
function Invoke-JiraReorderScreenTabField {
    [CmdletBinding(DefaultParameterSetName="Position")]
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

        # The position to move the field to
        [Parameter(Mandatory,Position=3,ParameterSetName="Position")]
        [ValidateSet("First","Earlier","Later","Last")]
        [string]
        $Position,

        # The uri of the field to move the field after
        [Parameter(Mandatory,Position=3,ParameterSetName="After")]
        [string]
        $AfterUri,

        # The JiraContext object to use for the request
        [Parameter()]
        [object]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/screens/$ScreenId/tabs/$TabId/fields/$FieldId/move"
        $verb = "POST"

        $body = New-PACRestMethodJsonBody
        if($PSBoundParameters.ContainsKey("Position")){$body.Add("position",$Position)}
        if($PSBoundParameters.ContainsKey("AfterUri")){$body.Add("after",$AfterUri)}

        $method = New-PACRestMethod $functionPath $verb $null $body
        $method.Invoke($JiraContext)
    }
}