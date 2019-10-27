$JiraCommentExpand = @("renderedBody")

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-comment-post
function Invoke-JiraAddComment {
    [CmdletBinding()]
    param (
        # The comment body
        [Parameter(Mandatory,Position=0)]
        [string]
        $CommentBody,

        # The ID of the issue
        [Parameter(Mandatory,Position=1,ValueFromPipeline,ValueFromPipelineByPropertyName,ParameterSetName="Id")]
        [int32]
        $Id,

        # The key of the issue
        [Parameter(Mandatory,Position=1,ValueFromPipeline,ValueFromPipelineByPropertyName,ParameterSetName="Key")]
        [string]
        $Key,
        
        # Used to expand additional attributes
        [Parameter(Position=2)]
        [ValidateScript({ Compare-StringArraySubset $JiraCommentExpand $_ })]
        [string[]]
        $Expand,
        
        # Set the visibility of the comment.  Use New-JiraVisibility
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

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    begin {
        $results = @()
    }
    process {
        $issueToken = IIF ($PSCmdlet.ParameterSetName -eq "Id") $Id $Key
        $functionPath = "/rest/api/2/issue/$issueToken/comment"
        $verb = "POST"

        $query = [RestMethodQueryParams]::new()
        if($PSBoundParameters.ContainsKey("Expand")){$query.Add("expand",$Expand -join ",")}

        $body = [RestMethodJsonBody]::new(@{
            body = $CommentBody
            jsdPublic = !$JsdHide
        })
        if($PSBoundParameters.ContainsKey("Visibility")){$body.Add("visibility",$Visibility)}
        if($PSBoundParameters.ContainsKey("Properties")){$body.Add("properties",$Properties)}

        $method = [BodyRestMethod]::new($functionPath,$verb,$query,$body)
        $results += $method.Invoke($JiraContext)
    }
    end {
        $results
    }
}