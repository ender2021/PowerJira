#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-application-properties-advanced-settings-get
function Invoke-JiraGetAdvancedSettings {
    [CmdletBinding()]
    param (
        # The JiraConnection object to use for the request
        [Parameter(Position=0)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/application-properties/advanced-settings"
        $verb = "GET"

        Invoke-JiraRestRequest $JiraConnection $functionPath $verb
    }
}