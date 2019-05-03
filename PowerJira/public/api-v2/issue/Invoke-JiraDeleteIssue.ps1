#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-delete
function Invoke-JiraDeleteIssue {
    [CmdletBinding()]
    param (
        # The ID of the issue
        [Parameter(Mandatory,Position=0,ValueFromPipeline,ValueFromPipelineByPropertyName,ParameterSetName="Id")]
        [int32]
        $Id,

        # The key of the issue
        [Parameter(Mandatory,Position=0,ValueFromPipeline,ValueFromPipelineByPropertyName,ParameterSetName="Key")]
        [string]
        $Key,

        # Set this flag to delete the issue's subtasks
        [Parameter(ValueFromPipelineByPropertyName)]
        [switch]
        $DeleteSubtasks,

        # The JiraConnection object to use for the request
        [Parameter(Position=1)]
        [hashtable]
        $JiraConnection
    )
    begin {
        $results = @()
    }
    process {
        $issueToken = IIF ($PSCmdlet.ParameterSetName -eq "Id") $Id $Key
        $functionPath = "/rest/api/2/issue/$issueToken"
        $verb = "DELETE"

        $query=@{
            deleteSubtasks = $DeleteSubtasks
        }

        $results += Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Query $query
    }
    end {
        #$results
    }
}