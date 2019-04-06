#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-projectvalidate-validProjectKey-get
function Invoke-JiraGetValidProjectKey {
    [CmdletBinding()]
    param (
        # The key to validate
        [Parameter(Mandatory,Position=0)]
        [string]
        $Key,

        # The JiraConnection object to use for the request
        [Parameter(Position=1)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/projectvalidate/validProjectKey"

        $query=@{
            key = $Key
        }

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "GET" -QueryParams $query
    }
}