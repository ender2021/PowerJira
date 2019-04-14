#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issuetype-id-delete
function Invoke-JiraDeleteIssueType {
    [CmdletBinding()]
    param (
        # The ID of the issue type
        [Parameter(Mandatory,Position=0)]
        [string]
        $IssueTypeId,

        # ID of an issue type to replace this issue type, if the deleted type is currently in use
        [Parameter(Position=1)]
        [string]
        $ReplacementId,

        # The JiraConnection object to use for the request
        [Parameter(Position=2)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issuetype/$IssueTypeId"
        $verb = "DELETE"

        $query = @{}
        if($PSBoundParameters.ContainsKey("ReplacementId")){$body.Add("alternativeIssueTypeId",$ReplacementId)}

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Query $query
    }
}