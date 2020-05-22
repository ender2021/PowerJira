#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-role-id-actors-post
function Invoke-JiraAddDefaultActorsToProjectRole {
    [CmdletBinding(DefaultParameterSetName="Users")]
    param (
        # The id of the role to retrieve
        [Parameter(Mandatory,Position=0)]
        [int64]
        $RoleId,

        # Account IDs for users to add to the role
        [Parameter(Mandatory,ParameterSetName="Users",Position=1)]
        [string[]]
        $Users,

        # Group names for groups to add to the role
        [Parameter(Mandatory,ParameterSetName="Groups",Position=1)]
        [string[]]
        $Groups,

        # The JiraContext object to use for the request
        [Parameter()]
        [object]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/role/$RoleId/actors"
        $verb = "POST"

        $body = New-PACRestMethodJsonBody
        if($PSBoundParameters.ContainsKey("Users")){$body.Add("user",$Users)}
        if($PSBoundParameters.ContainsKey("Groups")){$body.Add("group",$Groups)}

        $method = New-PACRestMethod $functionPath $verb $null $body
        $method.Invoke($JiraContext).actors
    }
}