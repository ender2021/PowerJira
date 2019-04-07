#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-attachments-post
function Invoke-JiraAddAttachment {
    [CmdletBinding()]
    param (
        # The issue Id or Key
        [Parameter(Mandatory,Position=0)]
        [string]
        $IssueIdOrKey,

        # Attachment file object (use the output of a Get-Item call)
        [Parameter(Mandatory,Position=1)]
        [object]
        $Attachment,

        # The JiraConnection object to use for the request
        [Parameter()]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issue/$issueIdOrKey/attachments"
        $verb = "POST"

        $form = @{file=$Attachment}

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod $verb -Form $form
    }
}