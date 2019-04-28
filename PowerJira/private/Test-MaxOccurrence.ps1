function Test-MaxOccurrence {
    [CmdletBinding()]
    param (
        # List of values
        [Parameter(Mandatory,Position=0)]
        [object[]]
        $Values,

        # The maximum number of ocurrences in the list that is valid
        [Parameter(Position=1)]
        [int64]
        $Count=1
    )process {
        ($Values | Group-Object | ForEach-Object { $_.count } | Measure-Object -Maximum).Maximum -le $Count
    }
}