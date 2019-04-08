$JiraIssueExpand = @("renderedFields","names","schema","transitions","editmeta","changelog","versionedRepresentations")

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-get
function Invoke-JiraGetIssue {
    [CmdletBinding()]
    param (
        # The ID or Key of the issue
        [Parameter(Mandatory,Position=0)]
        [string]
        $IssueIdOrKey,

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
    process {
        $functionPath = "/rest/api/2/issue/$IssueIdOrKey"
        $verb = "GET"
     
        $query = @{}
        if($PSBoundParameters.ContainsKey("Expand")){$query.Add("expand",$Expand -join ",")}
        
        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Query $query
    }
}