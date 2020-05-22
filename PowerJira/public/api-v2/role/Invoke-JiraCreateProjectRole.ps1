#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-role-post
function Invoke-JiraCreateProjectRole {
    [CmdletBinding()]
    param (
        # The name of the role to create
        [Parameter(Mandatory,Position=0)]
        [ValidateLength(1,255)]
        [string]
        $Name,

        # Option role description
        [Parameter(Position=1)]
        [string]
        $Description,

        # The JiraContext object to use for the request
        [Parameter()]
        [object]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/role"
        $verb = "POST"

        $body = New-PACRestMethodJsonBody @{
            name = $Name.Trim()
        }
        if($PSBoundParameters.ContainsKey("description")){$body.Add("description",$Description)}

        $method = New-PACRestMethod $functionPath $verb $null $body
        $method.Invoke($JiraContext)
    }
}