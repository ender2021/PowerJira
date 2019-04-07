#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-comment-commentId-properties-propertyKey-get
function Invoke-JiraGetCommentProperty {
    [CmdletBinding()]
    param (
        # The issue Id or Key
        [Parameter(Mandatory,Position=0)]
        [string]
        $CommentId,

        # The key name for the property
        [Parameter(Mandatory,Position=1)]
        [ValidateLength(1,255)]
        [string]
        $Key,

        # The JiraConnection object to use for the request
        [Parameter(Position=3)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/comment/$CommentId/properties/$Key"
        $verb = "GET"

        Invoke-JiraRestRequest $JiraConnection $functionPath $verb
    }
}