#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-watchers-post
function Invoke-JiraAddWatcher {
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

        # The account ID of the user to add
        [Parameter(Position=1,ValueFromPipelineByPropertyName)]
        [string]
        $AccountId,

        # The JiraConnection object to use for the request
        [Parameter(Position=2)]
        [hashtable]
        $JiraConnection
    )
    begin {
        $results = @()
    }
    process {
        $issueToken = IIF ($PSCmdlet.ParameterSetName -eq "Id") $Id $Key
        $functionPath = "/rest/api/2/issue/$issueToken/watchers"
        $verb = "POST"

        $body=""
        if($PSBoundParameters.ContainsKey("AccountId")){$body = """$AccountId"""}

        $results += Invoke-JiraRestMethod $JiraConnection $functionPath $verb -LiteralBody $body
    }
    end {
        #$results
    }
}