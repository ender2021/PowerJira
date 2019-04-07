#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-version-id-relatedIssueCounts-get
function Invoke-JiraGetVersionRelatedIssueCounts {
    [CmdletBinding()]
    param (
        # The ID of the version
        [Parameter(Mandatory,Position=0)]
        [int32]
        $VersionId,

        # The JiraConnection object to use for the request
        [Parameter(Position=1)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/version/$VersionId/relatedIssueCounts"
        $verb = "GET"
    
        Invoke-JiraRestRequest $JiraConnection $functionPath $verb
    }
}