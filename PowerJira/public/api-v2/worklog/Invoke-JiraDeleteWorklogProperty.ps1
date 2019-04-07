#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-worklog-worklogId-properties-propertyKey-delete
function Invoke-JiraDeleteWorklogProperty {
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

        # The key for the property to retrieve
        [Parameter(Mandatory,Position=2)]
        [string]
        $PropertyKey,

        # The JiraConnection object to use for the request
        [Parameter(Position=3)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issue/$IssueIdOrKey/worklog/$WorklogId/properties/$PropertyKey"
        $verb = "DELETE"

        Invoke-JiraRestRequest $JiraConnection $functionPath $verb
    }
}