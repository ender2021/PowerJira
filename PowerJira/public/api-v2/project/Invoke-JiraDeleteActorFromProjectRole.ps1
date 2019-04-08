#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-project-projectIdOrKey-role-id-delete
function Invoke-JiraDeleteActorFromProjectRole {
    [CmdletBinding(DefaultParameterSetName="User")]
    param (
        # THe project id or key to retrieve roles for
        [Parameter(Mandatory,Position=0)]
        [string]
        $ProjectIdOrKey,

        # The id of the role to retrieve
        [Parameter(Mandatory,Position=1)]
        [int64]
        $RoleId,

        # Account ID for user to remove from the role
        [Parameter(Mandatory,ParameterSetName="User",Position=2)]
        [string]
        $User,

        # Group name for group to remove to the role
        [Parameter(Mandatory,ParameterSetName="Group",Position=2)]
        [string]
        $Group,

        # The JiraConnection object to use for the request
        [Parameter(Position=3)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/project/$ProjectIdOrKey/role/$RoleId"
        $verb = "DELETE"

        $query = @{}
        if($PSBoundParameters.ContainsKey("User")){$query.Add("user",$User)}
        if($PSBoundParameters.ContainsKey("Group")){$query.Add("group",$Group)}

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Query $query
    }
}