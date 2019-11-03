#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-resolution-id-get
function Invoke-JiraGetResolution {
    [CmdletBinding()]
    param (
        # The Id of the resolution to retrieve
        [Parameter(Mandatory,Position=0)]
        [string]
        $ResolutionId,

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/resolution/$ResolutionId"
        $verb = "GET"

        $method = New-Object RestMethod @($functionPath,$verb)
        $method.Invoke($JiraContext)
    }
}