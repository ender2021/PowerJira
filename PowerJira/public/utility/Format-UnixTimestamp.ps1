function Format-UnixTimestamp {
    [CmdletBinding()]
    param (
        # A datetime value to convert to Unix timestamp
        [Parameter(Mandatory,Position=0)]
        [datetime]
        $DateTime
    )
    process {
        (New-TimeSpan -Start (Get-Date "01/01/1970") -End $DateTime).TotalSeconds
    }
}