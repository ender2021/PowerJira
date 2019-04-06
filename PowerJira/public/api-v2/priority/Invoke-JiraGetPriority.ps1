#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-priority-id-get
function Invoke-JiraGetPriority {
    [CmdletBinding()]
    param (
        # The ID of the priority to return
        [Parameter(Mandatory,Position=0)]
        [int32]
        $PriorityId,

        # The JiraConnection object to use for the request
        [Parameter(Position=1)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/priority/$PriorityId"
        $verb = "GET"

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod $verb
    }
}