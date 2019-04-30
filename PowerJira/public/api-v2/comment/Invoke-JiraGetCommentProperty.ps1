#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-comment-commentId-properties-propertyKey-get
function Invoke-JiraGetCommentProperty {
    [CmdletBinding()]
    param (
        # The comment id
        [Parameter(Mandatory,Position=0,ValueFromPipelineByPropertyName)]
        [int64]
        $Id,

        # The key name for the property
        [Parameter(Mandatory,Position=1,ValueFromPipelineByPropertyName)]
        [AllowEmptyCollection()]
        [string[]]
        $Keys,

        # The JiraConnection object to use for the request
        [Parameter(Position=3)]
        [hashtable]
        $JiraConnection
    )
    begin {
        $results = @()
    }
    process {
        if ($Keys.Count -gt 0) {
            $Keys | ForEach-Object {
                $functionPath = "/rest/api/2/comment/$Id/properties/$_"
                $verb = "GET"
        
                $results += Invoke-JiraRestMethod $JiraConnection $functionPath $verb
            }
        }
    }
    end {
        $results
    }
}