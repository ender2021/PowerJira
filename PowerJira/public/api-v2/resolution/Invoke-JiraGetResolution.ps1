#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-resolution-id-get
function Invoke-JiraGetResolution {
    [CmdletBinding()]
    param (
        # The Id of the resolution to retrieve
        [Parameter(Mandatory,Position=0)]
        [string]
        $ResolutionId,

        # The JiraConnection object to use for the request
        [Parameter(Position=1)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/resolution/$ResolutionId"
        $verb = "GET"

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod $verb
    }
}