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
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/mypreferences/locale"
        $verb = "PUT"

        $body = New-Object RestMethodJsonBody @{
            locale = $Locale
        }

        $method = New-Object BodyRestMethod @($functionPath,$verb,$body)
        $method.Invoke($JiraContext)
    }
}