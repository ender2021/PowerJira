function Compare-StringArraySubset {
    [CmdletBinding()]
    param (
        # The full list of valid values for an input array
        [Parameter(Mandatory,Position=0)]
        [ValidateNotNullOrEmpty()]
        [string[]]
        $Superset,

        # The list of values to be validated against the superset
        [Parameter(Mandatory,Position=1)]
        [ValidateNotNullOrEmpty()]
        [string[]]
        $Subset
    )
    process {
        $toReturn = $true
        $Subset | ForEach-Object { if (!$Superset.Contains($_)) {$toReturn = $false} }
        $toReturn
    }
}