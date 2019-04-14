#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issuetype-issueTypeId-properties-propertyKey-put
function Invoke-JiraSetIssueTypeProperty {
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

        # The value to set
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
        $functionPath = "/rest/api/2/issuetype/$IssueTypeId/properties/$PropertyKey"
        $verb = "PUT"

        $body=$Value

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Body $body
    }
}