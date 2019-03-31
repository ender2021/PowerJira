function New-JiraRemoteLinkIcon {
    [CmdletBinding()]
    param (
        # A URL to a 16 x 16 icon image
        [Parameter(Mandatory,Position=0)]
        [string]
        $Url16x16,

        # The title of the icon image
        [Parameter(Mandatory,Position=1)]
        [string]
        $Title,

        # A url for a tooltip (used only for the Status object)
        [Parameter(Position=2)]
        [string]
        $ToolTipLink,

        
        # Additional properties to add to the remote object
        [Parameter(Position=3)]
        [hashtable]
        $AdditionalProperties
    )
    process {
        $icon = @{
            url16x16 = $Url16x16
            title = $Title
        }
        if($PSBoundParameters.ContainsKey("ToolTipLink")){$icon.Add("link",$ToolTipLink)}
        if($PSBoundParameters.ContainsKey("AdditionalProperties")){$icon += $AdditionalProperties}

        $icon
    }
}