#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-user-get
function Invoke-JiraGetUser {
    [CmdletBinding()]
    param (
        # The accountID of the user to retrieve
        [Parameter(Mandatory,Position=0)]
        [string]
        $AccountId,

        # Set this flag to expand the user's group membership
        [Parameter(Position=1)]
        [switch]
        $ExpandGroups,

        # Set this flag to expand the user's application roles
        [Parameter(Position=2)]
        [switch]
        $ExpandApplicationRoles,

        # The JiraConnection object to use for the request
        [Parameter(Position=3)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/user"
        $verb = "GET"

        $expand = @()
        if($PSBoundParameters.ContainsKey("ExpandGroups")){$expand += "groups"}
        if($PSBoundParameters.ContainsKey("ExpandApplicationRoles")){$expand += "applicationRoles"}

        $body=@{
            accountId = $AccountId
        }
        if($expand.Length -gt 0){$body.Add("expand",$expand -join ",")}

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod $verb -Body $body
    }
}