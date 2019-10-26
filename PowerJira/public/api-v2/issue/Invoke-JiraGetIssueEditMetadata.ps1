#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-editmeta-get
function Invoke-JiraGetIssueEditMetadata {
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
        $functionPath = "/rest/api/2/issue/$issueToken/editmeta"
        $verb = "GET"
        
        $method = [RestMethod]::new($functionPath,$verb)
        $obj = $method.Invoke($JiraContext)
        if($PSBoundParameters.ContainsKey("Id")){$obj | Add-Member "Id" $Id}
        if($PSBoundParameters.ContainsKey("Key")){$obj | Add-Member "Key" $Key}
        $results += $obj
    }
    end {
        $results
    }
}