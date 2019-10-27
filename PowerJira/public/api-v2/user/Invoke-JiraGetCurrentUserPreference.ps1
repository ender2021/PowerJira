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
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/mypreferences"
        $verb = "GET"

        $query = [RestMethodQueryParams]::new(@{
            key = $PreferenceKey
        })

        $method = [RestMethod]::new($functionPath,$verb,$query)
        $method.Invoke($JiraContext)
    }
}