#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-mypreferences-delete
function Invoke-JiraResetCurrentUserPreference {
    [CmdletBinding()]
    param (
        # the key for the preference to retrieve
        [Parameter(Mandatory,Position=0)]
        [ValidateSet("user.notifications.mimetype","user.notify.own.changes","jira.user.locale","jira.user.timezone",
                     "user.default.share.private","user.keyboard.shortcuts.disabled","user.autowatch.disabled")]
        [string]
        $Preference,

        # The JiraConnection object to use for the request
        [Parameter(Position=1)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/mypreferences"
        $verb = "DELETE"

        $query=@{
            key = $Preference
        }

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Query $query
    }
}