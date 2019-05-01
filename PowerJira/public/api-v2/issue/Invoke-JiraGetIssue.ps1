$JiraIssueExpand = @("renderedFields","names","schema","transitions","editmeta","changelog","versionedRepresentations")

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-get
function Invoke-JiraGetIssue {
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

        # Used to expand additional attributes
        [Parameter(Position=1)]
        [ValidateScript({ Compare-StringArraySubset $JiraIssueExpand $_ })]
        [string[]]
        $Expand,

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
        $functionPath = "/rest/api/2/issue/$issueToken"
        $verb = "GET"
     
        $query = @{}
        if($PSBoundParameters.ContainsKey("Expand")){$query.Add("expand",$Expand -join ",")}
        
        $results += Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Query $query
    }
    end {
        $results
    }
}