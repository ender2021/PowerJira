function New-JiraRemoteApplication {
    [CmdletBinding()]
    param (
        # The name-spaced type of the application, used by registered rendering apps.
        [Parameter(Mandatory,Position=0)]
        [string]
        $Type,

        # The name of the application. Used in conjunction with the (remote) object icon title to display a tooltip for the link's icon.
        [Parameter(Mandatory,Position=1)]
        [string]
        $Name
    )
    process {
        @{
            type = $Type
            name = $Name
        }
    }
}