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
        $Subset,

        # Set this flag to treat items in the superset as regular expressions
        [Parameter()]
        [switch]
        $Regex
    )
    process {
        $toReturn = $true
        $Subset | ForEach-Object { 
            $eval = $false
            if ($Regex) {
                $item = $_
                $Superset | ForEach-Object { if ($item -match $_) { $eval = $true } }
            } else {
                $eval = $Superset -contains $_
            }
            if (!$eval) {$toReturn = $false} 
        }
        $toReturn
    }
}