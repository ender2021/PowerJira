#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-jql-pdcleaner-post
function Invoke-JiraReplacePersonalIdentifiers {
    [CmdletBinding()]
    param (
        # An array of up to 100 jql strings to perform replacement on
        [Parameter(Mandatory,Position=0)]
        [string[]]
        $Queries,

        # The JiraConnection object to use for the request
        [Parameter(Position=1)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/jql/pdcleaner"
        $verb = "POST"

        $body=@{
            queryStrings = $Queries
        }

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Body $body
    }
}