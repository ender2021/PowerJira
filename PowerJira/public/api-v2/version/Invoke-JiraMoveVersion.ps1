#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-version-id-move-post
function Invoke-JiraMoveVersion {
    [CmdletBinding()]
    param (
        # The ID of the version to update
        [Parameter(Mandatory,Position=0)]
        [int32]
        $VersionId,

        # Move this version to immediately after another specified target version. Provide the self link of the target.
        [Parameter(Mandatory,Position=1,ParameterSetName="After")]
        [uri]
        $After,

        # Move this version to a new position relative to the list or itself.
        [Parameter(Mandatory,Position=1,ParameterSetName="Position")]
        [ValidateSet("Earlier","Later","First","Last")]
        [string]
        $Position,
        
        # The JiraConnection object to use for the request
        [Parameter(Position=2)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/version/$VersionId/move"
        $verb = "POST"
        
        $body = @{}
        if($PSBoundParameters.ContainsKey("After")){$body.Add("after",$After)} else {$body.Add("position",$Position)}

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod $verb -Body $body
    }
}