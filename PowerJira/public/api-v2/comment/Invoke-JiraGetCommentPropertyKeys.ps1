#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-comment-commentId-properties-get
function Invoke-JiraGetCommentPropertyKeys {
    [CmdletBinding()]
    param (
        # THe ID of the comment to retireve property keys for
        [Parameter(Mandatory,Position=0,ValueFromPipeline,ValueFromPipelineByPropertyName)]
        [int64]
        $Id,

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    begin {
        $results = @()
    }
    process {
        $functionPath = "/rest/api/2/comment/$Id/properties"
        $verb = "GET"

        $obj = [PSCustomObject]@{
            id = $Id
            keys = @()
        }

        $method = [RestMethod]::new($functionPath,$verb)
        $obj.keys += $method.Invoke($JiraContext).keys | ForEach-Object {$_.key}
        $results += $obj

    }
    end {
        $results
    }
}