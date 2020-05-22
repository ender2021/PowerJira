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
        [object]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/issueLinkType"
        $verb = "POST"

        $body = New-PACRestMethodJsonBody @{
            name = $Name
            inward = $Inward
            outward = $Outward
        }

        $method = New-PACRestMethod $functionPath $verb $null $body
        $method.Invoke($JiraContext)
    }
}