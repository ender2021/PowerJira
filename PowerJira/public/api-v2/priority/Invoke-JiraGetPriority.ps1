#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-priority-id-get
function Invoke-JiraGetPriority {
    [CmdletBinding()]
    param (
        # The ID of the priority to return
        [Parameter(Mandatory,Position=0)]
        [int32]
        $PriorityId,

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/priority/$PriorityId"
        $verb = "GET"

        $method = New-Object RestMethod @($functionPath,$verb)
        $method.Invoke($JiraContext)
    }
}