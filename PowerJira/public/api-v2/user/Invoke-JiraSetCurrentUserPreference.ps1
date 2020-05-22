$JiraSystemPreferences = @("user.notifications.mimetype","user.notify.own.changes","jira.user.locale","jira.user.timezone","user.default.share.private","user.keyboard.shortcuts.disabled","user.autowatch.disabled")

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-mypreferences-put
function Invoke-JiraSetCurrentUserPreference {
    [CmdletBinding(DefaultParameterSetName="TextValue")]
    param (
        # the key for the preference to set
        [Parameter(Mandatory,Position=0)]
        [string]
        $PreferenceKey,

        # Use this parameter to pass a simple text value
        [Parameter(Mandatory,Position=1,ParameterSetName="TextValue")]
        [ValidateNotNullOrEmpty()]
        [string]
        $ValueText,

        # Use this parameter to pass a Json object
        [Parameter(Mandatory,Position=1,ParameterSetName="JsonValue")]
        [hashtable]
        $ValueJson,

        # The JiraContext object to use for the request
        [Parameter()]
        [object]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/mypreferences"
        $verb = "PUT"

        $query = New-PACRestMethodQueryParams @{
            key = $PreferenceKey
        }

        $body = if ($PSCmdlet.ParameterSetName -eq "TextValue") {
            New-PACRestMethodBody $ValueText
        } else {
            New-PACRestMethodJsonBody $ValueJson
        }
        
        $method = New-PACRestMethod $functionPath $verb $query $body
        $method.Invoke($JiraContext)
    }
}