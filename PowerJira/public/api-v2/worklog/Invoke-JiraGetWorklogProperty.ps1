#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-worklog-worklogId-properties-propertyKey-get
function Invoke-JiraGetWorklogProperty {
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

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/issue/$IssueIdOrKey/worklog/$WorklogId/properties/$PropertyKey"
        $verb = "GET"

        $method = [RestMethod]::new($functionPath,$verb)
        $method.Invoke($JiraContext)
    }
}