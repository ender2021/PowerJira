#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issuetype-id-get
function Invoke-JiraGetIssueType {
    [CmdletBinding()]
    param (
        # The ID of the issue type
        [Parameter(Mandatory,Position=0)]
        [string]
        $IssueTypeId,

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/issuetype/$IssueTypeId"
        $verb = "GET"

        $method = New-Object RestMethod @($functionPath,$verb)
        $method.Invoke($JiraContext)
    }
}