#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issueLinkType-issueLinkTypeId-get
function Invoke-JiraGetIssueLinkType {
    [CmdletBinding()]
    param (
        # THe ID of the issue link type
        [Parameter(Mandatory,Position=0)]
        [string]
        $LinkTypeId,

        # The JiraConnection object to use for the request
        [Parameter(Position=1)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issueLinkType/$LinkTypeId"
        $verb = "GET"

        Invoke-JiraRestRequest $JiraConnection $functionPath $verb
    }
}