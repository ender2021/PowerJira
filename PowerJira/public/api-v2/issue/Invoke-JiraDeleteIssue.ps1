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

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    begin {
        $results = @()
    }
    process {
        $issueToken = IIF ($PSCmdlet.ParameterSetName -eq "Id") $Id $Key
        $functionPath = "/rest/api/2/issue/$issueToken"
        $verb = "DELETE"

        $query= New-Object RestMethodQueryParams @{
            deleteSubtasks = $DeleteSubtasks
        }

        $method = New-Object RestMethod @($functionPath,$verb,$query)
        $results += $method.Invoke($JiraContext)
    }
    end {
        #$results
    }
}