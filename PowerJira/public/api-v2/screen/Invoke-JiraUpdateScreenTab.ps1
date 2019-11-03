#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-screens-screenId-tabs-put
function Invoke-JiraUpdateScreenTab {
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

        # The name of the new tab to create
        [Parameter(Mandatory,Position=2)]
        [string]
        $Name,

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/screens/$ScreenId/tabs/$TabId"
        $verb = "PUT"

        $body = New-Object RestMethodJsonBody
        if($PSBoundParameters.ContainsKey("Name")){$body.Add("name",$Name)}

        $method = New-Object BodyRestMethod @($functionPath,$verb,$body)
        $method.Invoke($JiraContext)
    }
}