function New-JiraContextJql {
    [CmdletBinding()]
    param (
        # The JQL to use
        [Parameter(Mandatory,Position=0)]
        [string]
        $Jql,

        # The index of the first item to return in the page of results (page offset). The base index is 0.
        [Parameter(Position=1)]
        [int64]
        $StartAt=0,

        # The maximum number of items to return per page. The default is 50 and the maximum is 1000.
        [Parameter(Position=2)]
        [ValidateRange(1,1000)]
        [int32]
        $MaxResults=50
    )
    process {
        @{
            jql = @{
                query = $Jql
                startAt = $StartAt
                maxResults = $MaxResults
            }
        }
    }
}