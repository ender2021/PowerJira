#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-group-delete
function Invoke-JiraDeleteGroup {
    [CmdletBinding()]
    param (
        # Name of the group to create
        [Parameter(Mandatory,Position=0)]
        [string]
        $Name,

        # The name of a group to replace the deleted group in comment/worklog restrictions
        [Parameter(Position=1)]
        [string]
        $SwapGroup,

        # The JiraConnection object to use for the request
        [Parameter(Position=2)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/group"
        $verb = "DELETE"

        $query=@{
            groupname = $Name
        }
        if($PSBoundParameters.ContainsKey("SwapGroup")){$query.Add("swapGroup",$SwapGroup)}

        Invoke-JiraRestRequest $JiraConnection $functionPath $verb -Query $query
    }
}