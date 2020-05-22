#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-statuscategory-idOrKey-get
function Invoke-JiraGetStatusCategory {
    [CmdletBinding()]
    param (
        # The status category Id or key
        [Parameter(Mandatory,Position=0)]
        [string]
        $CategoryIdOrKey,

        # The JiraContext object to use for the request
        [Parameter()]
        [object]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/statuscategory/$CategoryIdOrKey"
        $verb = "GET"

        $method = New-PACRestMethod $functionPath $verb
        $method.Invoke($JiraContext)
    }
}