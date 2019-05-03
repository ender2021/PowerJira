#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-properties-get
function Invoke-JiraGetIssuePropertyKeys {
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
        $functionPath = "/rest/api/2/issue/$issueToken/properties"
        $verb = "GET"

        $obj = [PSCustomObject]@{
            keys = @()
        }
        if($PSBoundParameters.ContainsKey("Id")){$obj | Add-Member "IssueId" $Id}
        if($PSBoundParameters.ContainsKey("Key")){$obj | Add-Member "IssueKey" $Key}

        $obj.keys += (Invoke-JiraRestMethod $JiraConnection $functionPath $verb).keys | ForEach-Object {$_.key}
        $results += $obj
    }
    end {
        $results
    }
}