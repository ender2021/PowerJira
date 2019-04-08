#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-editmeta-get
function Invoke-JiraGetIssueEditMetadata {
    [CmdletBinding()]
    param (
        # IDs of projects to return metadata for
        [Parameter(Mandatory,Position=0)]
        [string]
        $IssueIdOrKey,
        
        # The JiraConnection object to use for the request
        [Parameter(Position=1)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issue/$IssueIdOrKey/editmeta"
        $verb = "GET"
        
        Invoke-JiraRestMethod $JiraConnection $functionPath $verb
    }
}