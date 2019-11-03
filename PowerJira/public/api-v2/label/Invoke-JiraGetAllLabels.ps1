#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-label-get
function Invoke-JiraGetAllLabels {
    [CmdletBinding()]
    param (
        # The list index to start at if results are to be paginated
        [Parameter(Position=0)]
        [int64]
        $StartAt=0,

        # The Maximum results to be returned with the request
        [Parameter(Position=1)]
        [ValidateRange(1,1000)]
        [int32]
        $MaxResults=1000,
        
        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/label"
        $verb = "GET"

        $query = New-Object RestMethodQueryParams @{
            startAt = $StartAt
            maxResults = $MaxResults
        }

        $method = New-Object RestMethod @($functionPath,$verb,$query)
        $method.Invoke($JiraContext)
    }
}