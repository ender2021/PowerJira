function IIf {
    [CmdletBinding()]
    param (
        # Condition
        [Parameter(Mandatory,Position=0)]
        [bool]
        $Condition,

        # Value if true
        [Parameter(Mandatory,Position=1)]
        [AllowNull()]
        [object]
        $TrueValue,

        # Value if false
        [Parameter(Mandatory,Position=2)]
        [AllowNull()]
        [object]
        $FalseValue
    )
    process {
        if ($Condition) {$TrueValue} else {$FalseValue}
    }
}