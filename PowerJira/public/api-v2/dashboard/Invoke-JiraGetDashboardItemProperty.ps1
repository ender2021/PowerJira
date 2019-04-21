#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-dashboard-dashboardId-items-itemId-properties-propertyKey-get
function Invoke-JiraGetDashboardItemProperty {
    [CmdletBinding()]
    param (
        # The ID of the dashboard to retrieve
        [Parameter(Mandatory,Position=0)]
        [int64]
        $DashboardId,

        # The ID of the dashboard item
        [Parameter(Mandatory,Position=1)]
        [int64]
        $ItemId,

        # The key for the property to get
        [Parameter(Mandatory,Position=2)]
        [string]
        $PropertyKey,

        # The JiraConnection object to use for the request
        [Parameter(Position=3)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/dashboard/$DashboardId/items/$ItemId/properties/$PropertyKey"
        $verb = "GET"

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb
    }
}