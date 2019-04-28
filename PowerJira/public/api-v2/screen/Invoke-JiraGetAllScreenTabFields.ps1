#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-screens-screenId-tabs-tabId-fields-get
function Invoke-JiraGetAllScreenTabFields {
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

        # The project key
        [Parameter(Position=2)]
        [string]
        $ProjectKey,

        # The JiraConnection object to use for the request
        [Parameter(Position=3)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/screens/$ScreenId/tabs/$TabId/fields"
        $verb = "GET"

        $query = @{}
        if($PSBoundParameters.ContainsKey("ProjectKey")){$query.Add("projectKey",$ProjectKey)}

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Query $query
    }
}