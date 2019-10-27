$JiraCommentExpand = @("renderedBody")

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-comment-id-put
function Invoke-JiraUpdateComment {
    [CmdletBinding()]
    param (
        # The comment body
        [Parameter(Mandatory,Position=0,ValueFromPipelineByPropertyName)]
        [string]
        $Body,

        # The issue Id or Key
        [Parameter(Mandatory,Position=1,ValueFromPipelineByPropertyName)]
        [Alias("IssueId")]
        [string]
        $IssueKey,

        # The ID of the comment to retrieve
        [Parameter(Mandatory,Position=2,ValueFromPipeline,ValueFromPipelineByPropertyName)]
        [int64]
        $Id,

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

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    begin {
        $results = @()
    }
    process {
        $functionPath = "/rest/api/2/issue/$IssueKey/comment/$Id"
        $verb = "PUT"

        $query = [RestMethodQueryParams]::new()
        if($PSBoundParameters.ContainsKey("Expand")){$query.Add("expand",$Expand -join ",")}

        $b = [RestMethodJsonBody]::new(@{
            body = $Body
            jsdPublic = !$JsdHide
        })
        if($PSBoundParameters.ContainsKey("Visibility")){$b.Add("visibility",$Visibility)}
        if($PSBoundParameters.ContainsKey("Properties")){$b.Add("properties",$Properties)}

        $method = [BodyRestMethod]::new($functionPath,$verb,$query,$b)
        $results += $method.Invoke($JiraContext)
    }
    end {
        $results
    }
}