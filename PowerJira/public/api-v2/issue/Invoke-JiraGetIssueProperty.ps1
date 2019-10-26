#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-properties-propertyKey-get
function Invoke-JiraGetIssueProperty {
    [CmdletBinding()]
    param (
        # The issue Id or Key
        [Parameter(Mandatory,Position=0)]
        [string]
        $IssueIdOrKey,

        # The key name for the property
        [Parameter(Mandatory,Position=1)]
        [string]
        $Key,

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/issue/$IssueIdOrKey/properties/$Key"
        $verb = "GET"

        $method = [RestMethod]::new($functionPath,$verb)
        $method.Invoke($JiraContext)
    }
}