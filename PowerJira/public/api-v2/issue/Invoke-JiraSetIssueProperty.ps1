#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-properties-propertyKey-put
function Invoke-JiraSetIssueProperty {
    [CmdletBinding()]
    param (
        # The issue Id or Key
        [Parameter(Mandatory,Position=0)]
        [string]
        $IssueIdOrKey,

        # A key name for the property. Max length is 255
        [Parameter(Mandatory,Position=1)]
        [ValidateLength(1,255)]
        [string]
        $Key,

        # Supply any hashtable that can be converted to valid JSON.  The maximum serialized length is 32768 characters.
        [Parameter(Mandatory,Position=2)]
        [ValidateScript({ (ConvertTo-Json $_).Length -lt 32769 })]
        [hashtable]
        $Value,

        # The JiraConnection object to use for the request
        [Parameter(Position=3)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issue/$IssueIdOrKey/properties/$Key"
        $verb = "PUT"

        $body=$Value

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Body $body
    }
}