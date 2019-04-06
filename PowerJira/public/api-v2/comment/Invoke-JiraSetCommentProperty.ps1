#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-comment-commentId-properties-propertyKey-put
function Invoke-JiraSetCommentProperty {
    [CmdletBinding()]
    param (
        # The issue Id or Key
        [Parameter(Mandatory,Position=0)]
        [string]
        $CommentId,

        # A key name for the property. Max length is 255
        [Parameter(Mandatory,Position=1)]
        [ValidateLength(1,255)]
        [string]
        $Key,

        # Supply any hashtable that can be converted to valid JSON.  The maximum serialized length is 32768 characters.
        [Parameter(Mandatory,Position=2)]
        [ValidateScript({ (ConvertTo-Json $_).Length -le 32768 })]
        [hashtable]
        $Value,

        # The JiraConnection object to use for the request
        [Parameter(Position=3)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/comment/$CommentId/properties/$Key"
        $verb = "PUT"

        $body=$Value

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod $verb -Body $body
    }
}