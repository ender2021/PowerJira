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
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/filter/defaultShareScope"
        $verb = "PUT"

        $body = New-Object RestMethodJsonBody @{
            scope = $Scope
        }

        $method = New-Object BodyRestMethod @($functionPath,$verb,$body)
        $method.Invoke($JiraContext)
    }
}