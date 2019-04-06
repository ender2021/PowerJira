#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-remotelink-get
function Invoke-JiraGetRemoteIssueLinks {
    [CmdletBinding()]
    param (
        # The issue Id or Key
        [Parameter(Mandatory,Position=0)]
        [string]
        $IssueIdOrKey,

        # Optional parameter used to return only the specified link with matching global id
        [Parameter(Position=1)]
        [string]
        $GlobalId,

        # The JiraConnection object to use for the request
        [Parameter(Position=2)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issue/$IssueIdOrKey/remotelink"
        $verb = "GET"

        $body=@{}
        if($PSBoundParameters.ContainsKey("GlobalId")){$body.Add("globalId",$GlobalId)}

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod $verb -Body $body
    }
}