$JiraCommentsByIdsExpand = @("renderedBody","properties")

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-comment-list-post
function Invoke-JiraGetCommentsByIds {
    [CmdletBinding()]
    param (
        # A list of comment ids to return. Maximum of 1000 entries
        [Parameter(Mandatory,Position=0,ValueFromPipeline,ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({$_.Count -le 1000})]
        [int64[]]
        $Id,

        # Used to expand additional attributes
        [Parameter(Position=1)]
        [ValidateScript({ Compare-StringArraySubset $JiraCommentsByIdsExpand $_ })]
        [string[]]
        $Expand,
        
        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    begin {
        $idList = @()
    }
    process {
        $idList += $Id
    }
    end {
        $functionPath = "/rest/api/2/comment/list"
        $verb = "POST"

        $query = [RestMethodQueryParams]::new()
        if($PSBoundParameters.ContainsKey("Expand")){$query.Add("expand",$Expand -join ",")}

        $body = [RestMethodJsonBody]::new(@{
            ids = $idList
        })

        $method = [BodyRestMethod]::new($functionPath,$verb,$query,$body)
        $method.Invoke($JiraContext).values
    }
}