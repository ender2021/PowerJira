#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-serverInfo-get
function Invoke-JiraGetInstanceInfo {
    [CmdletBinding()]
    param (
        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/serverInfo"
        $verb = "GET"

        $method = New-Object RestMethod @($functionPath,$verb)
        $method.Invoke($JiraContext)
    }
}