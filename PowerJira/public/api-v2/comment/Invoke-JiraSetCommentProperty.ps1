#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-comment-commentId-properties-propertyKey-put
function Invoke-JiraSetCommentProperty {
    [CmdletBinding()]
    param (
        # The comment ID
        [Parameter(Mandatory,Position=0, ValueFromPipelineByPropertyName)]
        [string]
        $CommentId,

        # A key name for the property. Max length is 255
        [Parameter(Mandatory,Position=1, ValueFromPipelineByPropertyName)]
        [ValidateLength(1,255)]
        [string]
        $Key,

        # Supply any hashtable that can be converted to valid JSON.  The maximum serialized length is 32768 characters.
        [Parameter(Mandatory,Position=2, ValueFromPipelineByPropertyName)]
        [ValidateScript({ (ConvertTo-Json $_).Length -le 32768 })]
        [hashtable]
        $Value,

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    begin {
        $results = @()
    }
    process {
        $functionPath = "/rest/api/2/comment/$CommentId/properties/$Key"
        $verb = "PUT"

        $body = New-Object RestMethodJsonBody $Value

        $method = New-Object BodyRestMethod @($functionPath,$verb,$body)
        $results += $method.Invoke($JiraContext)
    }
    end {
        #$results
    }
}