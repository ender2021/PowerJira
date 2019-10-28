#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issueLinkType-post
function Invoke-JiraCreateIssueLinkType {
    [CmdletBinding()]
    param (
        # The name of the link type
        [Parameter(Mandatory,Position=0)]
        [string]
        $Name,

        # The inward description of the relationship (e.g. "Duplicated by")
        [Parameter(Mandatory,Position=1)]
        [string]
        $Inward,

        #  The outward description of the relationship (e.g. "Duplicates")
        [Parameter(Mandatory,Position=2)]
        [string]
        $Outward,

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/issueLinkType"
        $verb = "POST"

        $body = New-Object RestMethodJsonBody @{
            name = $Name
            inward = $Inward
            outward = $Outward
        }

        $method = New-Object BodyRestMethod @($functionPath,$verb,$body)
        $method.Invoke($JiraContext)
    }
}