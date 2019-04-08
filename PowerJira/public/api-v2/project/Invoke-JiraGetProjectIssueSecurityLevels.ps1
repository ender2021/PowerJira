#
function Invoke-JiraGetProjectIssueSecurityLevels {
    [CmdletBinding()]
    param (
        # The project Id or Key
        [Parameter(Mandatory,Position=0)]
        [string]
        $ProjectIdOrKey,

        # The JiraConnection object to use for the request
        [Parameter(Position=1)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/project/$ProjectIdOrKey/securitylevel"
        $verb = "GET"

        (Invoke-JiraRestMethod $JiraConnection $functionPath $verb).levels
    }
}