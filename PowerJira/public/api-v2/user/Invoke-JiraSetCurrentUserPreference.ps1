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

        # The JiraConnection object to use for the request
        [Parameter(Position=2)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/mypreferences"
        $verb = "PUT"

        $query=@{
            key = $PreferenceKey
        }

        if ($PSCmdlet.ParameterSetName -eq "TextValue") {
            Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Query $query -LiteralBody $ValueText
        } else {
            Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Query $query -Body $ValueJson
        }
    }
}