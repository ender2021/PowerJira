$JiraVersionExpand = @("operations","issuestatus")

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-version-id-GET
function Invoke-JiraGetVersion {
    [CmdletBinding()]
    param (
        # The ID of the version to update
        [Parameter(Mandatory,Position=0)]
        [int32]
        $VersionId,

        # Used to expand additional attributes
        [Parameter(Position=1)]
        [ValidateScript({ Compare-StringArraySubset $JiraVersionExpand $_ })]
        [string[]]
        $Expand,

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/version/$VersionId"
        $verb = "GET"
        
        $query = [RestMethodQueryParams]::new()
        if($PSBoundParameters.ContainsKey("Expand")){$query.Add("expand",$Expand -join ",")}
        
        $method = [RestMethod]::new($functionPath,$verb,$query)
        $method.Invoke($JiraContext)
    }
}