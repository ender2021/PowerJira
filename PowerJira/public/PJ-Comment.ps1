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

        # Set this flag to expand the comment body in the response
        [Parameter(Position=2)]
        [switch]
        $ExpandRenderedBody,

        # Set this value to restrict the comment visibility to a project role
        [Parameter(ParameterSetName="Role",Position=3)]
        [string]
        $SetRoleVisibility,

        # Set this value to restrict the comment visibility to a group
        [Parameter(ParameterSetName="Group",Position=4)]
        [string]
        $SetGroupVisibility,

        # Set this flag to hide this comment in Jira Service Desk
        [Parameter(Position=5)]
        [switch]
        $JsdHide,

        # Additional properties to add to the comment object
        [Parameter(Position=6)]
        [hashtable[]]
        $Properties,

        # The JiraConnection object to use for the request
        [Parameter(Position=7)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issue/$IssueIdOrKey/comment"

        #remove this line if Atlassian ever fixes this
        if($PSBoundParameters.ContainsKey("SetGroupVisibility")){throw "Restricting comment visibility by group is currently broken in the Jira API"}

        $body=@{
            body = $CommentBody
        }
        if($PSBoundParameters.ContainsKey("ExpandRenderedBody")){$body.Add("expand","renderedBody")}
        if($PSBoundParameters.ContainsKey("SetRoleVisibility")){$body.Add("visibility",@{type="role";value="$SetRoleVisibility"})}
        if($PSBoundParameters.ContainsKey("SetGroupVisibility")){$body.Add("visibility",@{type="group";value="$SetGroupVisibility"})}
        if($PSBoundParameters.ContainsKey("JsdHide")){$body.Add("jsdPublic",$false)}
        if($PSBoundParameters.ContainsKey("Properties")){$body.Add("properties",$Properties)}

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "POST" -Body $body
    }
}

Export-ModuleMember -Function * -Variable *