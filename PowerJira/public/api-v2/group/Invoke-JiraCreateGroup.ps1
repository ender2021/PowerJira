#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-group-post
function Invoke-JiraCreateGroup {
    [CmdletBinding()]
    param (
        # Name of the group to create
        [Parameter(Mandatory,Position=0)]
        [string]
        $Name,

        # The JiraConnection object to use for the request
        [Parameter(Position=1)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/group"
        $verb = "POST"

        $body=@{
            name = $Name
        }

        Invoke-JiraRestRequest $JiraConnection $functionPath $verb -Body $body
    }
}