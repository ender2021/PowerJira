#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-worklog-worklogId-properties-propertyKey-put
function Invoke-JiraSetWorklogProperty {
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

        # The value to set
        [Parameter(Mandatory,Position=3)]
        [ValidateScript({ (ConvertTo-Json $_).Length -lt 32769 })]
        [hashtable]
        $Value,

        # The JiraConnection object to use for the request
        [Parameter(Position=4)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issue/$IssueIdOrKey/worklog/$WorklogId/properties/$PropertyKey"
        $verb = "PUT"

        $body=$Value

        Invoke-JiraRestRequest $JiraConnection $functionPath $verb -Body $body
    }
}