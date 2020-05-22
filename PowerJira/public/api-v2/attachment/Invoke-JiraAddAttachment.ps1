#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-attachments-post
function Invoke-JiraAddAttachment {
    [CmdletBinding()]
    param (
        # The issue Id or Key
        [Parameter(Mandatory,Position=0,ValueFromPipeline,ValueFromPipelineByPropertyName)]
        [string]
        $IssueIdOrKey,

        # Attachment file object (use the output of a Get-Item call)
        [Parameter(Mandatory,Position=1,ValueFromPipeline)]
        [object[]]
        $Attachments,

        # The JiraContext object to use for the request
        [Parameter()]
        [object]
        $JiraContext
    )
    begin {
        $results = @()
    }
    process {
        $functionPath = "/rest/api/2/issue/$issueIdOrKey/attachments"
        $verb = "POST"

        foreach($item in $Attachments) {
            $form = @{file=$item}

            $method = New-PACRestMethod $functionPath $verb $null $form
            $results += $method.Invoke($JiraContext)
        }
    }
    end {
        $results
    }
}