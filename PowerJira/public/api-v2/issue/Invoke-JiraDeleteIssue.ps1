#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-delete
function Invoke-JiraDeleteIssue {
    [CmdletBinding()]
    param (
        # The issue Id or Key
        [Parameter(Mandatory,Position=0)]
        [string]
        $IssueIdOrKey,

        # Set this flag to delete the issue's subtasks
        [Parameter()]
        [switch]
        $DeleteSubtasks,

        # The JiraConnection object to use for the request
        [Parameter(Position=1)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issue/$IssueIdOrKey"

        $body=@{}
        if($PSBoundParameters.ContainsKey("DeleteSubtasks")){$body.Add("deleteSubtasks",$true)}

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "DELETE" -Body $body
    }
}