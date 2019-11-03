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

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/group"
        $verb = "DELETE"

        $query = New-Object RestMethodQueryParams @{
            groupname = $Name
        }
        if($PSBoundParameters.ContainsKey("SwapGroup")){$query.Add("swapGroup",$SwapGroup)}

        $method = New-Object RestMethod @($functionPath,$verb,$query)
        $method.Invoke($JiraContext)
    }
}