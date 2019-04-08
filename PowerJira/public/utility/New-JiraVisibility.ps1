function New-JiraVisibility {
    [CmdletBinding()]
    param (
        # Indicates whether visibility of this item is restricted to a group or role.
        [Parameter(Mandatory,Position=0)]
        [ValidateSet("role")]
        [string]
        $Type,

        # The name of the group or role to which visibility of this item is restricted.
        [Parameter(Mandatory,Position=1)]
        [string]
        $Value
    )
    process {
        @{
            type = $Type
            value = $Value
        }
    }
}