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

        # Set the visibility of the comment.  Use New-JiraCommentVisibility
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

        # Additional properties to add to the remote object
        [Parameter(Position=6)]
        [hashtable]
        $AdditionalProperties,
        
        # Set this flag to hide this comment in Jira Service Desk
        [Parameter(Position=7)]
        [switch]
        $JsdHide,

        # The JiraConnection object to use for the request
        [Parameter(Position=8)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issue/$IssueIdOrKey/comment/$CommentId"
        if($PSBoundParameters.ContainsKey("Expand")){$functionPath += "?expand" + $Expand -join ","}

        $body=@{
            body = $CommentBody
        }
        if($PSBoundParameters.ContainsKey("Visibility")){$body.Add("visibility",$Visibility)}
        if($PSBoundParameters.ContainsKey("JsdHide")){$body.Add("jsdPublic",$false)}
        if($PSBoundParameters.ContainsKey("Properties")){$body.Add("properties",$Properties)}
        if($PSBoundParameters.ContainsKey("AdditionalProperties")){$body += $AdditionalProperties}

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "PUT" -Body $body
    }
}