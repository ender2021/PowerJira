#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-statuscategory-idOrKey-get
function Invoke-JiraGetStatusCategory {
    [CmdletBinding()]
    param (
        # The status category Id or key
        [Parameter(Mandatory,Position=0)]
        [string]
        $CategoryIdOrKey,

        # The JiraConnection object to use for the request
        [Parameter()]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/statuscategory/$CategoryIdOrKey"

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "GET"
    }
}