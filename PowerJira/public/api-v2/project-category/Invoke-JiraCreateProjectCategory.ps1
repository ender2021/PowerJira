#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-projectCategory-post
function Invoke-JiraCreateProjectCategory {
    [CmdletBinding()]
    param (
        # A name for the category
        [Parameter(Mandatory,Position=0)]
        [string]
        $Name,

        # A description for the category
        [Parameter(Mandatory,Position=1)]
        [string]
        $Description,

        # The JiraContext object to use for the request
        [Parameter()]
        [object]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/projectCategory"
        $verb = "POST"

        $body = New-PACRestMethodJsonBody @{
            name = $Name
            description = $Description
        }

        $method = New-PACRestMethod $functionPath $verb $null $body
        $method.Invoke($JiraContext)
    }
}