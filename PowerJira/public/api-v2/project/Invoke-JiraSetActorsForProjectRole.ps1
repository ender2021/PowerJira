#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-project-projectIdOrKey-role-id-put
function Invoke-JiraSetActorsForProjectRole {
    [CmdletBinding(DefaultParameterSetName="Users")]
    param (
        # THe project id or key to retrieve roles for
        [Parameter(Mandatory,Position=0)]
        [string]
        $ProjectIdOrKey,

        # The id of the role to retrieve
        [Parameter(Mandatory,Position=1)]
        [int64]
        $RoleId,

        # Account IDs for users to add to the role
        [Parameter(Mandatory,ParameterSetName="Users",Position=2)]
        [Parameter(Mandatory,ParameterSetName="Users,Groups",Position=2)]
        [string[]]
        $Users,

        # Group names for groups to add to the role
        [Parameter(Mandatory,ParameterSetName="Groups",Position=2)]
        [Parameter(Mandatory,ParameterSetName="Users,Groups",Position=3)]
        [string[]]
        $Groups,

        # The JiraContext object to use for the request
        [Parameter()]
        [object]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/project/$ProjectIdOrKey/role/$RoleId"
        $verb = "PUT"

        $body = New-PACRestMethodJsonBody @{
            categorisedActors = @{}
        }
        if($PSBoundParameters.ContainsKey("Users")){$body.Values.categorisedActors.Add("atlassian-user-role-actor",$Users)}
        if($PSBoundParameters.ContainsKey("Groups")){$body.Values.categorisedActors.Add("atlassian-group-role-actor",$Groups)}

        $method = New-PACRestMethod $functionPath $verb $null $body
        $method.Invoke($JiraContext)
    }
}