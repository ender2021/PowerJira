#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-comment-commentId-properties-propertyKey-delete
function Invoke-JiraDeleteCommentProperty {
    [CmdletBinding()]
    param (
        # The id of the comment with the property
        [Parameter(Mandatory,Position=0,ValueFromPipelineByPropertyName)]
        [string]
        $Id,

        # The key name for the property
        [Parameter(Mandatory,Position=1,ValueFromPipeline,ValueFromPipelineByPropertyName)]
        [ValidateLength(1,255)]
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
                $verb = "DELETE"

                $results += Invoke-JiraRestMethod $JiraConnection $functionPath $verb
            }
        }
    }
    end {
        #$results
    }
}