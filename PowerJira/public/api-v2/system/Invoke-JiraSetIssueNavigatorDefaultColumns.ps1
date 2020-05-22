#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-settings-columns-put
function Invoke-JiraSetIssueNavigatorDefaultColumns {
    [CmdletBinding()]
    param (
        # An array of field names to display as columns
        [Parameter(Mandatory,Position=0)]
        [ValidateNotNullOrEmpty()]
        [string[]]
        $Columns,

        # The JiraContext object to use for the request
        [Parameter()]
        [object]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/settings/columns"
        $verb = "PUT"

        $body = New-PACRestMethodJsonBody @{
            columns = $Columns
        }

        $method = New-PACRestMethod $functionPath $verb $null $body
        $method.Invoke($JiraContext)
    }
}