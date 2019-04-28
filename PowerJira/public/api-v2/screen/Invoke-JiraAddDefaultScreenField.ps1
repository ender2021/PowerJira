#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-screens-addToDefault-fieldId-post
function Invoke-JiraAddDefaultScreenField {
    [CmdletBinding()]
    param (
        # The ID of the field to add
        [Parameter(Mandatory,Position=0)]
        [string]
        $FieldId,

        # The JiraConnection object to use for the request
        [Parameter(Position=1)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/screens/addToDefault/$FieldId"
        $verb = "POST"

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb
    }
}