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

        # The JiraConnection object to use for the request
        [Parameter(Position=3)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issueLinkType"
        $verb = "POST"

        $body=@{
            name = $Name
            inward = $Inward
            outward = $Outward
        }

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Body $body
    }
}