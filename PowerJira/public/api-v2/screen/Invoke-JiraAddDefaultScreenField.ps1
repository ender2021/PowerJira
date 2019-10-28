#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-screens-addToDefault-fieldId-post
function Invoke-JiraAddDefaultScreenField {
    [CmdletBinding()]
    param (
        # The ID of the field to add
        [Parameter(Mandatory,Position=0)]
        [string]
        $FieldId,

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/screens/addToDefault/$FieldId"
        $verb = "POST"

        $method = New-Object RestMethod @($functionPath,$verb)
        $method.Invoke($JiraContext)
    }
}