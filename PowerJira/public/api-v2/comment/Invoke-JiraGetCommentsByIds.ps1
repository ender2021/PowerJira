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
        
        # The JiraConnection object to use for the request
        [Parameter(Position=2)]
        [hashtable]
        $JiraConnection
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

        $query = @{}
        if($PSBoundParameters.ContainsKey("Expand")){$query.Add("expand",$Expand -join ",")}

        $body=@{
            ids = $idList
        }

        (Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Query $query -Body $body).values
    }
}