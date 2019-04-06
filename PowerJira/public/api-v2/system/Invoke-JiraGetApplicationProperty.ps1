#
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

        $body=@{}
        if($PSBoundParameters.ContainsKey("Key")){$body.Add("key",$Key)}
        if($PSBoundParameters.ContainsKey("KeyFilter")){$body.Add("keyFilter",$KeyFilter)}
        if($PSBoundParameters.ContainsKey("PermissionLevel")){$body.Add("permissionLevel",$PermissionLevel)}

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod $verb -Body $body
    }
}