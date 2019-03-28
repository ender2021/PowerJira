function Test-Id {
    param (
        # The value to be tested
        [Parameter(Mandatory)]
        [string]
        $Value
    )
    process {
        $Value -match "^[\d\.]+$"
    }
}