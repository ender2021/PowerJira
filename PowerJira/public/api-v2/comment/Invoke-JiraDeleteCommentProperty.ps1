#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-comment-commentId-properties-propertyKey-delete
function Invoke-JiraDeleteCommentProperty {
    [CmdletBinding()]
    param (
        # The id of the comment with the property
        [Parameter(Mandatory,Position=0,ValueFromPipelineByPropertyName)]
        [int64]
        $Id,

        # The key name for the property
        [Parameter(Mandatory,Position=1,ValueFromPipeline,ValueFromPipelineByPropertyName)]
        [ValidateLength(1,255)]
        [string[]]
        $Keys,

        # The JiraContext object to use for the request
        [Parameter()]
        [object]
        $JiraContext
    )
    begin {
        $results = @()
    }
    process {
        if ($Keys.Count -gt 0) {
            $Keys | ForEach-Object {
                $functionPath = "/rest/api/2/comment/$Id/properties/$_"
                $verb = "DELETE"

                $method = New-PACRestMethod $functionPath $verb
                $results += $method.Invoke($JiraContext)
            }
        }
    }
    end {
        #$results
    }
}