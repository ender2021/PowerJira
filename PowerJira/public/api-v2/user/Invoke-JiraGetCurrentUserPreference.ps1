$JiraSystemPreferences = @("user.notifications.mimetype","user.notify.own.changes","jira.user.locale","jira.user.timezone","user.default.share.private","user.keyboard.shortcuts.disabled","user.autowatch.disabled")

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-mypreferences-get
function Invoke-JiraGetCurrentUserPreference {
    [CmdletBinding()]
    param (
        # the key for the preference to retrieve
        [Parameter(Mandatory,Position=0)]
        [string]
        $PreferenceKey,

        # The JiraContext object to use for the request
        [Parameter()]
        [object]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/mypreferences"
        $verb = "GET"

        $query = New-PACRestMethodQueryParams @{
            key = $PreferenceKey
        }

        $method = New-PACRestMethod $functionPath $verb $query
        $method.Invoke($JiraContext)
    }
}