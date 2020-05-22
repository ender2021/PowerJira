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
        [object]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/filter/$FilterId/columns"
        $verb = "PUT"

        $body = New-PACRestMethodJsonBody @{
            columns = $Columns
        }

        $method = New-PACRestMethod $functionPath $verb $null $body
        $method.Invoke($JiraContext)
    }
}