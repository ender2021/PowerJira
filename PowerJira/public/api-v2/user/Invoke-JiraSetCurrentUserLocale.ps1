#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-mypreferences-locale-put
function Invoke-JiraSetCurrentUserLocale {
    [CmdletBinding()]
    param (
        # The locale to set
        [Parameter(Mandatory,Position=0)]
        [ValidateScript({$_ -match "^[a-z]{2}_[A-Z]{2}$"})]
        [string]
        $Locale,

        # The JiraContext object to use for the request
        [Parameter()]
        [object]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/mypreferences/locale"
        $verb = "PUT"

        $body = New-PACRestMethodJsonBody @{
            locale = $Locale
        }

        $method = New-PACRestMethod $functionPath $verb $null $body
        $method.Invoke($JiraContext)
    }
}