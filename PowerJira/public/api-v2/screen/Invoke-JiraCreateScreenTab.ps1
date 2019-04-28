#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-screens-screenId-tabs-post
function Invoke-JiraCreateScreenTab {
    [CmdletBinding()]
    param (
        # The ID of the field to add
        [Parameter(Mandatory,Position=0)]
        [int64]
        $ScreenId,

        # The name of the new tab to create
        [Parameter(Mandatory,Position=1)]
        [string]
        $Name,

        # The JiraConnection object to use for the request
        [Parameter(Position=2)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/screens/$ScreenId/tabs"
        $verb = "POST"

        $body = @{}
        if($PSBoundParameters.ContainsKey("Name")){$body.Add("name",$Name)}

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Body $body
    }
}