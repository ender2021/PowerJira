#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-component-id-get
function Invoke-JiraGetComponent {
    [CmdletBinding()]
    param (
        # The ID of the Component to retrieve
        [Parameter(Mandatory,Position=0)]
        [int32]
        $ComponentId,

        # The JiraContext object to use for the request
        [Parameter()]
        [object]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/component/$ComponentId"
        $verb = "GET"

        $method = New-PACRestMethod $functionPath $verb
        $method.Invoke($JiraContext)
    }
}