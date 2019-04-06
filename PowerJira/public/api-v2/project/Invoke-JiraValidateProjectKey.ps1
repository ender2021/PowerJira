#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-projectvalidate-key-get
function Invoke-JiraValidateProjectKey {
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
        $functionPath = "/rest/api/2/projectvalidate/key"
        $verb = "GET"

        $query=@{
            key = $Key
        }

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod $verb -QueryParams $query
    }
}