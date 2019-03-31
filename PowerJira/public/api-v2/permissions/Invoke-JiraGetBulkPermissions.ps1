#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-permissions-check-post
function Invoke-JiraGetBulkPermissions {
    [CmdletBinding(DefaultParameterSetName="Global")]
    param (
        # Global permissions to return
        [Parameter(Mandatory,ParameterSetName="Global",Position=0)]
        [Parameter(Mandatory,ParameterSetName="Global,Project",Position=0)]
        [string[]]
        $GlobalPermissions,

        # Project permissions to return
        [Parameter(Mandatory,ParameterSetName="Project",Position=0)]
        [Parameter(Mandatory,ParameterSetName="Global,Project",Position=1)]
        [ValidateNotNullOrEmpty()]
        [string[]]
        $ProjectPermissions,

        # Project permissions to return
        [Parameter(ParameterSetName="Project",Position=1)]
        [Parameter(ParameterSetName="Global,Project",Position=2)]
        [ValidateNotNullOrEmpty()]
        [int64[]]
        $ProjectIds,

        # Project permissions to return
        [Parameter(ParameterSetName="Project",Position=2)]
        [Parameter(ParameterSetName="Global,Project",Position=3)]
        [ValidateNotNullOrEmpty()]
        [int64[]]
        $IssueIds,

        # The JiraConnection object to use for the request
        [Parameter(ParameterSetName="Global",Position=1)]
        [Parameter(ParameterSetName="Project",Position=3)]
        [Parameter(ParameterSetName="Global,Project",Position=4)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/permissions/check"

        $body = @{}
        if($PSBoundParameters.ContainsKey("GlobalPermissions")){$body.Add("globalPermissions",$GlobalPermissions)}
        if(($PSCmdlet.ParameterSetName -eq "Project") -or ($PSCmdlet.PagingParameters -eq "Global,Project")) {
            $body.Add("projectPermissions", @(@{
                permissions = $ProjectPermissions
            }))
            if($PSBoundParameters.ContainsKey("ProjectIds")){$body.projectPermissions[0].Add("projects",$ProjectIds)}
            if($PSBoundParameters.ContainsKey("IssueIds")){$body.projectPermissions[0].Add("issues",$IssueIds)}
        }

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "POST" -Body $body
    }
}