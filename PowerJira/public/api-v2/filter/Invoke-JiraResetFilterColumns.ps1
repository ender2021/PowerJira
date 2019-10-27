#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-filter-id-columns-delete
function Invoke-JiraResetFilterColumns {
    [CmdletBinding()]
    param (
        # The filter id
        [Parameter(Mandatory,Position=0)]
        [int64]
        $FilterId,

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/filter/$FilterId/columns"
        $verb = "DELETE"

        $method = New-Object RestMethod @($functionPath,$verb)
        $method.Invoke($JiraContext)
    }
}