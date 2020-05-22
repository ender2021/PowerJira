#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-jql-pdcleaner-post
function Invoke-JiraReplacePersonalIdentifiers {
    [CmdletBinding()]
    param (
        # An array of up to 100 jql strings to perform replacement on
        [Parameter(Mandatory,Position=0)]
        [string[]]
        $Queries,

        # The JiraContext object to use for the request
        [Parameter()]
        [object]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/jql/pdcleaner"
        $verb = "POST"

        $body = New-PACRestMethodJsonBody @{
            queryStrings = $Queries
        }

        $method = New-PACRestMethod $functionPath $verb $null $body
        $method.Invoke($JiraContext)
    }
}