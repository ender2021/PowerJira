# https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-myself-get
function Invoke-JiraGetCurrentUser {
    [CmdletBinding()]
    param (
        # Expand groups attribute
        [Parameter(Mandatory=$false)]
        [Switch]
        $ExpandGroups,

        # Expand applicationRoles attribute
        [Parameter(Mandatory=$false)]
        [Switch]
        $ExpandApplicationRoles,

        # The JiraConnection object to use for the request
        [Parameter(Mandatory=$false)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/myself"

        $expand = @()
        $body = @{}
        if($PSBoundParameters.ContainsKey("ExpandGroups")){$expand += "groups"} 
        if($PSBoundParameters.ContainsKey("ExpandApplicationRoles")){$expand += "applicationRoles"}
        if($expand.Count -gt 0) {$body.Add("expand",$expand -join ",")}
    
        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "GET" -Body $body
    }
}