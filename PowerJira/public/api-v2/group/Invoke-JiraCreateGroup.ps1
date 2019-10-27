#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-group-post
function Invoke-JiraCreateGroup {
    [CmdletBinding()]
    param (
        # Name of the group to create
        [Parameter(Mandatory,Position=0)]
        [string]
        $Name,

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/group"
        $verb = "POST"

        $body = New-Object RestMethodJsonBody @{
            name = $Name
        }

        $method = New-Object BodyRestMethod @($functionPath,$verb,$body)
        $method.Invoke($JiraContext)
    }
}