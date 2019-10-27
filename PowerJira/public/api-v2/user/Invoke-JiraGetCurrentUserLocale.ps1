#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-mypreferences-locale-get
function Invoke-JiraGetCurrentUserLocale {
    [CmdletBinding()]
    param (
        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/mypreferences/locale"
        $verb = "GET"

        $method = [RestMethod]::new($functionPath,$verb)
        $method.Invoke($JiraContext)
    }
}