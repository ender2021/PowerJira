#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-projectCategory-id-get
function Invoke-JiraGetProjectCategory {
    [CmdletBinding()]
    param (
        # The id of the category to retrieve
        [Parameter(Mandatory,Position=0)]
        [int64]
        $CategoryId,

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/projectCategory/$CategoryId"
        $verb = "GET"

        $method = New-Object RestMethod @($functionPath,$verb)
        $method.Invoke($JiraContext)
    }
}