#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-dashboard-id-get
function Invoke-JiraGetDashboard {
    [CmdletBinding()]
    param (
        # The ID of the dashboard to retrieve
        [Parameter(Mandatory,Position=0)]
        [int64]
        $DashboardId,

        # The JiraConnection object to use for the request
        [Parameter(Position=1)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/dashboard/$DashboardId"
        $verb = "GET"

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb
    }
}