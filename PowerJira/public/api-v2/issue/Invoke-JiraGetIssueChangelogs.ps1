#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-changelog-get
function Invoke-JiraGetIssueChangelogs {
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

        # The index of the first item to return in the page of results (page offset). The base index is 0.
        [Parameter(Position=1,ValueFromPipelineByPropertyName)]
        [int32]
        $StartAt=0,

        # The maximum number of items to return per page. The default is 100 and the maximum is 100.
        [Parameter(Position=2,ValueFromPipelineByPropertyName)]
        [ValidateRange(1,100)]
        [int32]
        $MaxResults=100,
        
        # Set this flag to return only log values without wrapper object
        [Parameter()]
        [switch]
        $ValuesOnly,

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
        $functionPath = "/rest/api/2/issue/$issueToken/changelog"
        $verb = "GET"

        $query=New-Object RestMethodQueryParams @{
            startAt = $StartAt
            maxResults = $MaxResults
        }

        if($PSBoundParameters.ContainsKey("Id")){
            $issueMemberName = "IssueId"
            $issueMemberValue = $Id
        } else {
            $issueMemberName = "IssueKey"
            $issueMemberValue = $Key
        }
        
        $method = New-Object RestMethod @($functionPath,$verb,$query)
        $obj = $method.Invoke($JiraContext)
        $obj | Add-Member $issueMemberName $issueMemberValue
        $obj.values | ForEach-Object {$_ | Add-Member $issueMemberName $issueMemberValue}
        $results += IIF $ValuesOnly $obj.values $obj
    }
    end {
        $results
    }
}