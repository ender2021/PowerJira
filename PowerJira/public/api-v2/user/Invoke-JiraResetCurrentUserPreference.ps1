$JiraSystemPreferences = @("user.notifications.mimetype","user.notify.own.changes","jira.user.locale","jira.user.timezone","user.default.share.private","user.keyboard.shortcuts.disabled","user.autowatch.disabled")

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-mypreferences-delete
function Invoke-JiraResetCurrentUserPreference {
    [CmdletBinding()]
    param (
        # the key for the preference to retrieve
        [Parameter(Mandatory,Position=0)]
        [string]
        $PreferenceKey,

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/mypreferences"
        $verb = "DELETE"

        $query = New-Object RestMethodQueryParams @{
            key = $PreferenceKey
        }

        $method = New-Object RestMethod @($functionPath,$verb,$query)
        $method.Invoke($JiraContext)
    }
}