#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-filter-id-columns-put
function Invoke-JiraSetFilterColumns {
    [CmdletBinding()]
    param (
        # The filter id
        [Parameter(Mandatory,Position=0)]
        [int64]
        $FilterId,

        # An array of field names to display as columns
        [Parameter(Mandatory,Position=1)]
        [ValidateNotNullOrEmpty()]
        [string[]]
        $Columns,

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/filter/$FilterId/columns"
        $verb = "PUT"

        $body = New-Object RestMethodJsonBody @{
            columns = $Columns
        }

        $method = New-Object BodyRestMethod @($functionPath,$verb,$body)
        $method.Invoke($JiraContext)
    }
}