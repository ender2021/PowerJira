#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-screens-screenId-tabs-get
function Invoke-JiraGetAllScreenTabs {
    [CmdletBinding()]
    param (
        # The ID of the field to add
        [Parameter(Mandatory,Position=0)]
        [int64]
        $ScreenId,

        # The related project Key
        [Parameter(Position=1)]
        [string]
        $ProjectKey,

        # The JiraConnection object to use for the request
        [Parameter(Position=2)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/screens/$ScreenId/tabs"
        $verb = "GET"

        $query = @{}
        if($PSBoundParameters.ContainsKey("ProjectKey")){$query.Add("projectKey",$ProjectKey)}

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Query $query
    }
}