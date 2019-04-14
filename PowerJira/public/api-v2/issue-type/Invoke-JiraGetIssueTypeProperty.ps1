#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issuetype-issueTypeId-properties-propertyKey-get
function Invoke-JiraGetIssueTypeProperty {
    [CmdletBinding()]
    param (
        # The issue type ID
        [Parameter(Mandatory,Position=0)]
        [string]
        $IssueTypeId,

        # The key for the property to set
        [Parameter(Mandatory,Position=1)]
        [string]
        $PropertyKey,

        # The JiraConnection object to use for the request
        [Parameter(Position=2)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issuetype/$IssueTypeId/properties/$PropertyKey"
        $verb = "GET"

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb
    }
}