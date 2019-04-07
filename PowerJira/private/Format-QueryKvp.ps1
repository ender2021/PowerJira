function Format-QueryKvp {
    [CmdletBinding()]
    param (
        # The Key
        [Parameter(Mandatory,Position=0)]
        [string]
        $Key,

        # The value
        [Parameter(Mandatory,Position=1)]
        [object]
        $Value
    )
    process {
        @{key=$Key;value=$Value}
    }
}