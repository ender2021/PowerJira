#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-version-id-move-post
function Invoke-JiraMoveVersion {
    [CmdletBinding()]
    param (
        # The ID of the version to update
        [Parameter(Mandatory=$true)]
        [int32]
        $VersionId,

        # Move this version to immediately after another specified target version. Provide the self link of the target.
        [Parameter(Mandatory=$true,ParameterSetName="After")]
        [uri]
        $After,

        # Move this version to a new position relative to the list or itself.
        [Parameter(Mandatory=$true,ParameterSetName="Position")]
        [ValidateSet("Earlier","Later","First","Last")]
        [string]
        $Position,
        
        # The JiraConnection object to use for the request
        [Parameter(Mandatory=$false)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/version/$VersionId/move"
        
        $body = @{}
        if($PSBoundParameters.ContainsKey("After")){$body.Add("after",$After)} else {$body.Add("position",$Position)}

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "POST" -Body $body
    }
}