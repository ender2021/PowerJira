#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-application-properties-id-put
function Invoke-JiraSetApplicationProperty {
    [CmdletBinding()]
    param (
        # ID of the property to set
        [Parameter(Mandatory,Position=0)]
        [string]
        $PropertyId,

        # The new value for the property
        [Parameter(Mandatory,Position=1)]
        [string]
        $Value,

        # The JiraContext object to use for the request
        [Parameter()]
        [object]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/application-properties/$PropertyId"
        $verb = "PUT"

        $body = New-PACRestMethodJsonBody @{
            id = $PropertyId
            value = $Value
        }

        $method = New-PACRestMethod $functionPath $verb $null $body
        $method.Invoke($JiraContext)
    }
}