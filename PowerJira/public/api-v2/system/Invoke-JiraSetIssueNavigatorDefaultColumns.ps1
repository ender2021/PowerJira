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
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/settings/columns"
        $verb = "PUT"

        $body = New-Object RestMethodJsonBody @{
            columns = $Columns
        }

        $method = New-Object BodyRestMethod @($functionPath,$verb,$body)
        $method.Invoke($JiraContext)
    }
}