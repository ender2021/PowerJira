#
function Invoke-JiraSetDefaultShareScope {
    [CmdletBinding()]
    param (
        # The scope to set.
        [Parameter(Mandatory,Position=0)]
        [ValidateSet("AUTHENTICATED","GLOBAL","PRIVATE")]
        [string]
        $Scope,

        # The JiraConnection object to use for the request
        [Parameter(Position=1)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/filter/defaultShareScope"
        $verb = "PUT"

        $body=@{
            scope = $Scope
        }

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Body $body
    }
}