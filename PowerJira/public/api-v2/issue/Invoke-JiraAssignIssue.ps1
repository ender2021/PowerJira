#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-assignee-put
function Invoke-JiraAssignIssue {
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

        # The account ID of the user to assign
        [Parameter(Position=1,ValueFromPipelineByPropertyName)]
        [string]
        $AccountId,

        # Set this flag to assign the issue to the default assignee for the project
        [Parameter(ValueFromPipelineByPropertyName)]
        [switch]
        $ProjectDefault,

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
        $functionPath = "/rest/api/2/issue/$issueToken/assignee"
        $verb = "PUT"

        $body = New-Object RestMethodJsonBody @{
            accountId = IIF $PSBoundParameters.ContainsKey("AccountId") $AccountId $null
        }
        if($PSBoundParameters.ContainsKey("ProjectDefault")){$body.Values.accountId = "-1"}

        $method = New-Object BodyRestMethod @($functionPath,$verb,$body)
        $results += $method.Invoke($JiraContext)
    }
    end {
        #$results
    }
}