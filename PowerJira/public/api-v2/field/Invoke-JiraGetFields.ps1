#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-field-get
function Invoke-JiraGetFields {
    [CmdletBinding()]
    param (
        # The JiraConnection object to use for the request
        [Parameter(Position=0)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/field"
        $verb = "GET"

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb
    }
}