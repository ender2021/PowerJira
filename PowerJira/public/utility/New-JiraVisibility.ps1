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
        $Value,
    
        # Additional properties to add to the remote object
        [Parameter(Position=2)]
        [hashtable]
        $AdditionalProperties
    )
    process {
        $obj = @{
            type = $Type
            value = $Value
        }
        if($PSBoundParameters.ContainsKey("AdditionalProperties")){$obj += $AdditionalProperties}

        $obj
    }
}