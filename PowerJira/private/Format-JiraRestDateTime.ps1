function Format-JiraRestDateTime {
    [CmdletBinding()]
    param (
        # The DateTime to format
        [Parameter(Mandatory=$true)]
        [datetime]
        $DateTime
    )
    process {
        ((Get-Date -Date $DateTime -Format "o") -replace "(.*):(.*)", '$1$2') -replace "(.*)(\.[0-9]{3})([0-9]{4})(.*)", '$1$2$4'
    }
}