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
    
        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/myself"
        $verb = "GET"

        $query = [RestMethodQueryParams]::new()
        if($PSBoundParameters.ContainsKey("Expand")){$query.Add("expand",$Expand -join ",")}
    
        $method = [RestMethod]::new($functionPath,$verb,$query)
        $method.Invoke($JiraContext)
    }
}