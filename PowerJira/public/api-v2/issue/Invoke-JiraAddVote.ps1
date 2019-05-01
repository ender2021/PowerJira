#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-votes-post
function Invoke-JiraAddVote {
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
        $functionPath = "/rest/api/2/issue/$issueToken/votes"
        $verb = "POST"

        $results += Invoke-JiraRestMethod $JiraConnection $functionPath $verb
    }
    end {
        $results
    }
}