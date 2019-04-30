$JiraCommentExpand = @("renderedBody")

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-comment-get
function Invoke-JiraGetComments {
    [CmdletBinding()]
    param (
        # The issue Id or Key
        [Parameter(Mandatory,Position=0,ValueFromPipeline,ValueFromPipelineByPropertyName)]
        [Alias("Id")]
        [string]
        $Key,

        # The index of the first item to return in the page of results (page offset). The base index is 0.
        [Parameter(Position=1)]
        [int32]
        $StartAt=0,

        # The maximum number of items to return per page. The default is 100 and the maximum is 100.
        [Parameter(Position=2)]
        [ValidateRange(1,100)]
        [int32]
        $MaxResults=50,

        # How to order the results
        [Parameter(Position=3)]
        [ValidateSet("created","-created")]
        [string]
        $OrderBy,

        # Used to expand additional attributes
        [Parameter(Position=4)]
        [ValidateScript({ Compare-StringArraySubset $JiraCommentExpand $_ })]
        [string[]]
        $Expand,

        # The JiraConnection object to use for the request
        [Parameter(Position=5)]
        [hashtable]
        $JiraConnection
    )
    begin {
        $results = @()
    }
    process {
        $functionPath = "/rest/api/2/issue/$Key/comment"
        $verb = "GET"

        $query=@{
            startAt = $StartAt
            maxResults = $MaxResults
        }
        if($PSBoundParameters.ContainsKey("OrderBy")){$query.Add("orderBy",$OrderBy)}
        if($PSBoundParameters.ContainsKey("Expand")){$query.Add("expand",$Expand -join ",")}

        $return = Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Query $query
        $return.comments | Add-Member (IIF (Test-Id $Key) "IssueId" "IssueKey")  $Key
        $results += $return.comments
    }
    end {
        $results
    }
}