$JiraWorklogExpand = @("properties")

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-worklog-get
function Invoke-JiraGetIssueWorklogs {
    [CmdletBinding()]
    param (
        # The issue Id or Key
        [Parameter(Mandatory,Position=0)]
        [string]
        $IssueIdOrKey,

        # The index of the first item to return in the page of results (page offset). The base index is 0.
        [Parameter(Position=1)]
        [int32]
        $StartAt=0,

        # The maximum number of items to return per page. The default is 1048576 and the maximum is 1048576.
        [Parameter(Position=2)]
        [ValidateRange(1,1048576)]
        [int32]
        $MaxResults=1048576,

        # Used to expand additional attributes
        [Parameter(Position=3)]
        [ValidateScript({ Compare-StringArraySubset $JiraWorklogExpand $_ })]
        [string[]]
        $Expand,

        # The JiraConnection object to use for the request
        [Parameter()]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issue/$IssueIdOrKey/worklog"
        $verb = "GET"

        $query = @{}
        if($PSBoundParameters.ContainsKey("Expand")){$query.Add("expand",$Expand -join ",")}

        $body=@{
            startAt = $StartAt
            maxResults = $MaxResults
        }

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod $verb -QueryParams $query -Body $body
    }
}