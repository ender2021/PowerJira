#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-customFieldOption-id-get
function Invoke-JiraGetCustomFieldOption {
    [CmdletBinding()]
    param (
        # The ID of the custom field
        [Parameter(Mandatory,Position=0)]
        [string]
        $FieldId,

        # The JiraConnection object to use for the request
        [Parameter(Position=1)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/customFieldOption/$FieldId"
        $verb = "GET"

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb
    }
}