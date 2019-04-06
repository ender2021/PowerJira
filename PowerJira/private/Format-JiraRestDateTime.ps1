function Format-JiraRestDateTime {
    [CmdletBinding()]
    param (
        # The DateTime to format
        [Parameter(Mandatory,Position=0)]
        [datetime]
        $DateTime,

        # Set this flag to use the simple date format
        [Parameter(Position=1)]
        [switch]
        $Simple
    )
    process {
        if ($Simple) {
            Get-Date -Date $DateTime -Format "o"
        } else {
            ((Get-Date -Date $DateTime -Format "o") -replace "(.*):(.*)", '$1$2') -replace "(.*)(\.[0-9]{3})([0-9]{4})(.*)", '$1$2$4'
        }
    }
}