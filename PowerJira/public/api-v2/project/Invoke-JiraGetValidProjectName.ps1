#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-projectvalidate-validProjectName-get
function Invoke-JiraGetValidProjectName {
    [CmdletBinding()]
    param (
        # The name to validate
        [Parameter(Mandatory,Position=0)]
        [string]
        $Name,

        # The JiraContext object to use for the request
        [Parameter()]
        [object]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/projectvalidate/validProjectName"
        $verb = "GET"

        $query = New-PACRestMethodQueryParams @{
            name = $Name
        }

        $method = New-PACRestMethod $functionPath $verb $query
        $method.Invoke($JiraContext)
    }
}