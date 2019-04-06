$JiraUserExpand = @("groups","applicationRoles")

# https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-myself-get
function Invoke-JiraGetCurrentUser {
    [CmdletBinding()]
    param (
        # Used to expand additional attributes
        [Parameter(Position=0)]
        [ValidateScript({ Compare-StringArraySubset $JiraUserExpand $_ })]
        [string[]]
        $Expand,
    
        # The JiraConnection object to use for the request
        [Parameter(Position=1)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/myself"
        $verb = "GET"

        $query = @{}
        if($PSBoundParameters.ContainsKey("Expand")){$query.Add("expand",$Expand -join ",")}
    
        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod $verb -QueryParams $query
    }
}