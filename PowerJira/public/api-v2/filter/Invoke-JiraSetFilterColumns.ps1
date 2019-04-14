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

        # The JiraConnection object to use for the request
        [Parameter(Position=2)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/filter/$FilterId/columns"
        $verb = "PUT"

        $body = @{
            columns = $Columns
        }

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Body $body
    }
}