#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-version-id-relatedIssueCounts-get
function Invoke-JiraGetVersionRelatedIssueCounts {
    [CmdletBinding()]
    param (
        # The ID of the version
        [Parameter(Mandatory,Position=0)]
        [int32]
        $VersionId,

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/version/$VersionId/relatedIssueCounts"
        $verb = "GET"
    
        $method = New-Object RestMethod @($functionPath,$verb)
        $method.Invoke($JiraContext)
    }
}