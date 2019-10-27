#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-dashboard-dashboardId-items-itemId-properties-propertyKey-put
function Invoke-JiraSetDashboardItemProperty {
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

        # The key for the property to set
        [Parameter(Mandatory,Position=2)]
        [string]
        $PropertyKey,

        # The value to set
        [Parameter(Mandatory,Position=3)]
        [ValidateScript({ (ConvertTo-Json $_).Length -lt 32769 })]
        [hashtable]
        $Value,

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/dashboard/$DashboardId/items/$ItemId/properties/$PropertyKey"
        $verb = "PUT"

        $body = New-Object RestMethodJsonBody $Value

        $method = New-Object BodyRestMethod @($functionPath,$verb,$body)
        $method.Invoke($JiraContext)
    }
}