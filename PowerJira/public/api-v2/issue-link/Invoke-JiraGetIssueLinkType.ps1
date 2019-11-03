#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issueLinkType-issueLinkTypeId-get
function Invoke-JiraGetIssueLinkType {
    [CmdletBinding()]
    param (
        # THe ID of the issue link type
        [Parameter(Mandatory,Position=0)]
        [string]
        $LinkTypeId,

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/issueLinkType/$LinkTypeId"
        $verb = "GET"

        $method = New-Object RestMethod @($functionPath,$verb)
        $method.Invoke($JiraContext)
    }
}