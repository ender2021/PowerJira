$JiraCommentExpand = @("renderedBody")

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-comment-post
function Invoke-JiraAddComment {
    [CmdletBinding(DefaultParameterSetName="Role")]
    param (
        # The issue Id or Key
        [Parameter(Mandatory,Position=0)]
        [string]
        $IssueIdOrKey,

        # The comment body
        [Parameter(Mandatory,Position=1)]
        [string]
        $CommentBody,

        # Used to expand additional attributes
        [Parameter(Position=2)]
        [ValidateScript({ Compare-StringArraySubset $JiraCommentExpand $_ })]
        [string[]]
        $Expand,
        
        # Set the visibility of the comment.  Use New-JiraCommentVisibility
        [Parameter(Position=3)]
        [hashtable]
        $Visibility,

        # Set this flag to hide this comment in Jira Service Desk
        [Parameter(Position=4)]
        [switch]
        $JsdHide,

        # Additional properties to add to the comment object
        [Parameter(Position=5)]
        [hashtable[]]
        $Properties,

        # The JiraConnection object to use for the request
        [Parameter(Position=6)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issue/$IssueIdOrKey/comment"
        $verb = "POST"

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