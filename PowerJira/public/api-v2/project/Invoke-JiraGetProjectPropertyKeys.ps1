#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-project-projectIdOrKey-properties-get
function Invoke-JiraGetProjectPropertyKeys {
    [CmdletBinding()]
    param (
        # The project Id or Key
        [Parameter(Mandatory,Position=0)]
        [string]
        $ProjectIdOrKey,

        # The JiraConnection object to use for the request
        [Parameter(Position=1)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/project/$ProjectIdOrKey/properties"

        (Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "GET").keys
    }
}