#
function Invoke-JiraSetDefaultShareScope {
    [CmdletBinding()]
    param (
        # The scope to set.
        [Parameter(Mandatory,Position=0)]
        [ValidateSet("AUTHENTICATED","GLOBAL","PRIVATE")]
        [string]
        $Scope,

        # The JiraContext object to use for the request
        [Parameter()]
        [object]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/filter/defaultShareScope"
        $verb = "PUT"

        $body = New-PACRestMethodJsonBody @{
            scope = $Scope
        }

        $method = New-PACRestMethod $functionPath $verb $null $body
        $method.Invoke($JiraContext)
    }
}