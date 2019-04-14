#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-settings-columns-put
function Invoke-JiraSetIssueNavigatorDefaultColumns {
    [CmdletBinding()]
    param (
        # An array of field names to display as columns
        [Parameter(Mandatory,Position=0)]
        [ValidateNotNullOrEmpty()]
        [string[]]
        $Columns,

        # The JiraConnection object to use for the request
        [Parameter(Position=1)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/settings/columns"
        $verb = "PUT"

        $body = @{
            columns = $Columns
        }

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Body $body
    }
}