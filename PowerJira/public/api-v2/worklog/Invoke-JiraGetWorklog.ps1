$JiraWorklogExpand = @("properties")

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-worklog-id-get
function Invoke-JiraGetWorklog {
    [CmdletBinding()]
    param (
        # The issue Id or Key
        [Parameter(Mandatory,Position=0)]
        [string]
        $IssueIdOrKey,

        # The issue Id or Key
        [Parameter(Mandatory,Position=1)]
        [string]
        $WorklogId,

        # Used to expand additional attributes
        [Parameter(Position=2)]
        [ValidateScript({ Compare-StringArraySubset $JiraWorklogExpand $_ })]
        [string[]]
        $Expand,

        # The JiraConnection object to use for the request
        [Parameter(Position=3)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issue/$IssueIdOrKey/worklog/$WorklogId"
        $verb = "GET"

        $query=@{}
        if($PSBoundParameters.ContainsKey("Expand")){$query.Add("expand",$Expand -join ",")}

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod $verb -QueryParams $query
    }
}