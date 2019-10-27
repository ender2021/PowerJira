#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-watchers-delete
function Invoke-JiraDeleteWatcher {
    [CmdletBinding(DefaultParameterSetName="Id")]
    param (
        # The ID of the issue
        [Parameter(Mandatory,Position=0,ValueFromPipeline,ValueFromPipelineByPropertyName,ParameterSetName="Id")]
        [int32]
        $Id,

        # The key of the issue
        [Parameter(Mandatory,Position=0,ValueFromPipeline,ValueFromPipelineByPropertyName,ParameterSetName="Key")]
        [string]
        $Key,

        # The account ID of the watcher to delete
        [Parameter(Mandatory,Position=1,ValueFromPipelineByPropertyName)]
        [string]
        $AccountId,

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
        $functionPath = "/rest/api/2/issue/$issueToken/watchers"
        $verb = "DELETE"

        $query = New-Object RestMethodQueryParams @{
            accountId = $AccountId
        }

        $method = New-Object RestMethod @($functionPath,$verb,$query)
        $results += $method.Invoke($JiraContext)
    }
    end {
        #$results
    }
}