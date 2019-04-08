#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-comment-commentId-properties-get
function Invoke-JiraGetCommentPropertyKeys {
    [CmdletBinding()]
    param (
        # THe ID of the comment to retireve property keys for
        [Parameter(Mandatory,Position=0)]
        [string]
        $CommentId,

        # The JiraConnection object to use for the request
        [Parameter(Position=1)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/comment/$CommentId/properties"
        $verb = "GET"

        (Invoke-JiraRestMethod $JiraConnection $functionPath $verb).keys
    }
}