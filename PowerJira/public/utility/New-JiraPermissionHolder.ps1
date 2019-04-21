$JiraParameterlessHolderTypes = @("anyone","assignee","projectLead","reporter","sd.customer.portal.only")
$JiraParameteredHolderTypes = @("applicationRole","group","groupCustomField","projectRole","user","userCustomFieldOutput")

function New-JiraPermissionHolder {
    [CmdletBinding()]
    param (
        # The type of the holder
        [Parameter(Mandatory,Position=0)]
        [ValidateSet("anyone","applicationRole","assignee","group","groupCustomField","projectLead",
                     "projectRole","reporter","sd.customer.portal.only","user","userCustomFieldOutput")]
        [string]
        $Type,

        # The parameter corresponding to the holder type
        [Parameter(Position=1)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Parameter
    )
    process {
        if ($PSBoundParameters.ContainsKey("Parameter") -and ($JiraParameterlessHolderTypes -contains $Type)) {
            throw "Parameter mismatch: Holder Type '$Type' does not accept a Parameter"
        } elseif (!$PSBoundParameters.ContainsKey("Parameter") -and ($JiraParameteredHolderTypes -contains $Type)) {
            $paramType = switch ($Type) {
                "applicationRole" { "application name" }
                "group" { "group name" }
                "groupCustomField" { "custom field ID" }
                "projectRole" { "project role ID" }
                "user" { "user account ID" }
                "userCustomFieldOutput" { "custom field ID" }
                Default {"unknown"}
            }

            throw "Parameter mismatch: Holder Type '$Type' requires $paramType to be supplied as the Parameter"
        }
        @{
            type = $Type
            parameter = $Parameter
        }
    }
}