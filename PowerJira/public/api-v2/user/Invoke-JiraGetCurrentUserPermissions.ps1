#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-mypermissions-get
function Invoke-JiraGetCurrentUserPermissions {
    [CmdletBinding()]
    param (
        # A list of permissions to return
        [Parameter(Mandatory,Position=0)]
        [ValidateNotNullOrEmpty()]
        [string[]]
        $Permissions,

        # Project key or id
        [Parameter(Position=1)]
        [string]
        $ProjectKeyOrId,

        # The issue Id or Key
        [Parameter(Position=2)]
        [string]
        $IssueIdOrKey,

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/mypermissions"
        $verb = "GET"

        $query = [RestMethodQueryParams]::new(@{
            permissions = $Permissions -join ","
        })
        if($PSBoundParameters.ContainsKey("ProjectIdOrKey")){
            $query.Add((IIf (Test-Id $ProjectIdOrKey) "projectId" "projectKey"),$ProjectIdOrKey)
        }
        if($PSBoundParameters.ContainsKey("IssueIdOrKey")){
            $query.Add((IIf (Test-Id $IssueIdOrKey) "issueId" "issueKey"),$IssueIdOrKey)
        }

        $method = [RestMethod]::new($functionPath,$verb,$query)
        $method.Invoke($JiraContext).permissions
    }
}