#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-dashboard-dashboardId-items-itemId-properties-get
function Invoke-JiraGetDashboardItemPropertyKeys {
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

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/dashboard/$DashboardId/items/$ItemId/properties"
        $verb = "GET"

        $method = New-Object RestMethod @($functionPath,$verb)
        $method.Invoke($JiraContext).keys
    }
}