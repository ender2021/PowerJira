$JiraCommentExpand = @("renderedBody")

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-comment-id-put
function Invoke-JiraUpdateComment {
    [CmdletBinding()]
    param (
        # The issue Id or Key
        [Parameter(Mandatory,Position=0)]
        [string]
        $IssueIdOrKey,

        # The ID of the comment to update
        [Parameter(Mandatory,Position=1)]
        [string]
        $CommentId,

        # The comment body
        [Parameter(Mandatory,Position=2)]
        [string]
        $CommentBody,

        # Set the visibility of the comment.  Use New-JiraVisibility
        [Parameter(Position=3)]
        [hashtable]
        $Visibility,

        # Used to expand additional attributes
        [Parameter(Position=4)]
        [ValidateScript({ Compare-StringArraySubset $JiraCommentExpand $_ })]
        [string[]]
        $Expand,
        
        # Additional properties to add to the comment object
        [Parameter(Position=5)]
        [hashtable[]]
        $Properties,

        # Set this flag to hide this comment in Jira Service Desk
        [Parameter(Position=6)]
        [switch]
        $JsdHide,

        # The JiraConnection object to use for the request
        [Parameter(Position=7)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issue/$IssueIdOrKey/comment/$CommentId"
        $verb = "PUT"

        $query = @{}
        if($PSBoundParameters.ContainsKey("Expand")){$query.Add("expand",$Expand -join ",")}

        $body=@{
            body = $CommentBody
        }
        if($PSBoundParameters.ContainsKey("Visibility")){$body.Add("visibility",$Visibility)}
        if($PSBoundParameters.ContainsKey("JsdHide")){$body.Add("jsdPublic",$false)}
        if($PSBoundParameters.ContainsKey("Properties")){$body.Add("properties",$Properties)}

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Query $query -Body $body
    }
}