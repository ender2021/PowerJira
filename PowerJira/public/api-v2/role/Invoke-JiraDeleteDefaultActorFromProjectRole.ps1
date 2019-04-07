#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-role-id-actors-delete
function Invoke-JiraDeleteDefaultActorFromProjectRole {
    [CmdletBinding(DefaultParameterSetName="User")]
    param (
        # The id of the role to retrieve
        [Parameter(Mandatory,Position=0)]
        [int64]
        $RoleId,

        # Account IDs for users to add to the role
        [Parameter(Mandatory,ParameterSetName="User",Position=1)]
        [string]
        $User,

        # Group names for groups to add to the role
        [Parameter(Mandatory,ParameterSetName="Group",Position=1)]
        [string]
        $Group,

        # The JiraConnection object to use for the request
        [Parameter(Position=2)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/role/$RoleId/actors"
        $verb = "DELETE"

        $query = @{}
        if($PSBoundParameters.ContainsKey("User")){$query.Add("user",$User)}
        if($PSBoundParameters.ContainsKey("Group")){$query.Add("group",$Group)}

        (Invoke-JiraRestRequest $JiraConnection $functionPath $verb -Query $query).actors
    }
}