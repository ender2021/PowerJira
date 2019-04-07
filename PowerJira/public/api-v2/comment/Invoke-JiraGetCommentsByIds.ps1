$JiraCommentsByIdsExpand = @("renderedBody","properties")

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-comment-list-post
function Invoke-JiraGetCommentsByIds {
    [CmdletBinding()]
    param (
        # A list of comment ids to return. Maximum of 1000 entries
        [Parameter(Mandatory,Position=0)]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({$_.Count -le 1000})]
        [int64[]]
        $CommentIds,

        # Used to expand additional attributes
        [Parameter(Position=1)]
        [ValidateScript({ Compare-StringArraySubset $JiraCommentsByIdsExpand $_ })]
        [string[]]
        $Expand,
        
        # The JiraConnection object to use for the request
        [Parameter(Position=2)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/comment/list"
        $verb = "POST"

        $query = @{}
        if($PSBoundParameters.ContainsKey("Expand")){$query.Add("expand",$Expand -join ",")}

        $body=@{
            ids = $CommentIds
        }

        Invoke-JiraRestRequest $JiraConnection $functionPath $verb -Query $query -Body $body
    }
}