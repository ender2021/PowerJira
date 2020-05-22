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

        # The JiraContext object to use for the request
        [Parameter()]
        [object]
        $JiraContext
    )
    begin {
        $results = @()
    }
    process {
        $issueToken = IIF ($PSCmdlet.ParameterSetName -eq "Id") $Id $Key
        $functionPath = "/rest/api/2/issue/$issueToken/watchers"
        $verb = "POST"

        $body = New-PACRestMethodBody
        if($PSBoundParameters.ContainsKey("AccountId")){$body.BodyString = """$AccountId"""}

        $method = New-PACRestMethod $functionPath $verb $null $body
        $results += $method.Invoke($JiraContext)
    }
    end {
        #$results
    }
}