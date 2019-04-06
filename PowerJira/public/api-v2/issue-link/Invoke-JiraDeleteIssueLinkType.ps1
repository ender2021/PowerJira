#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issueLinkType-issueLinkTypeId-delete
function Invoke-JiraDeleteIssueLinkType {
    [CmdletBinding()]
    param (
        # The Id of the Issue Link Type
        [Parameter(Mandatory,Position=0)]
        [string]
        $LinkTypeId,

        # The JiraConnection object to use for the request
        [Parameter(Position=4)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issueLinkType/$LinkTypeId"
        $verb = "DELETE"

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod $verb
    }
}