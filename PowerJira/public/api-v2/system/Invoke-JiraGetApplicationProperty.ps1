#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-application-properties-get
function Invoke-JiraGetApplicationProperty {
    [CmdletBinding(DefaultParameterSetName="Key")]
    param (
        # The key of the property to return
        [Parameter(ParameterSetName="Key",Position=0)]
        [string]
        $Key,

        # The key of the property to return
        [Parameter(Mandatory,ParameterSetName="Filter",Position=0)]
        [string]
        $KeyFilter,

        # Require that all properties returned have this permission level
        [Parameter(Position=1)]
        [string]
        $PermissionLevel,

        # The JiraConnection object to use for the request
        [Parameter(Position=2)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/application-properties"
        $verb = "GET"

        $query=@{}
        if($PSBoundParameters.ContainsKey("Key")){$query.Add("key",$Key)}
        if($PSBoundParameters.ContainsKey("KeyFilter")){$query.Add("keyFilter",$KeyFilter)}
        if($PSBoundParameters.ContainsKey("PermissionLevel")){$query.Add("permissionLevel",$PermissionLevel)}

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod $verb -Query $query
    }
}