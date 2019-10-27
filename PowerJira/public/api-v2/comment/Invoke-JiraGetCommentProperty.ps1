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

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    begin {
        $results = @()
    }
    process {
        if ($Keys.Count -gt 0) {
            $Keys | ForEach-Object {
                $functionPath = "/rest/api/2/comment/$Id/properties/$_"
                $verb = "GET"
        
                $method = New-Object RestMethod @($functionPath,$verb)
                $results += $method.Invoke($JiraContext)
            }
        }
    }
    end {
        $results
    }
}