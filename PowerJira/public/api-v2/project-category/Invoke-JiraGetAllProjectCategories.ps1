#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-projectCategory-get
function Invoke-JiraGetAllProjectCategories {
    [CmdletBinding()]
    param (
        # The JiraConnection object to use for the request
        [Parameter()]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/projectCategory"
        $verb = "GET"

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb
    }
}