#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-resolution-get
function Invoke-JiraGetResolutions {
    [CmdletBinding()]
    param (
        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/resolution"
        $verb = "GET"

        $method = New-Object RestMethod @($functionPath,$verb)
        $method.Invoke($JiraContext)
    }
}