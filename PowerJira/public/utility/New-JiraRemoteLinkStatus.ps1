function New-JiraRemoteLinkStatus {
    [CmdletBinding()]
    param (
        # A Jira icon object to associate with the remote object
        [Parameter(Position=0)]
        [hashtable]
        $Icon,

        # Additional properties to add to the remote object
        [Parameter(Position=1)]
        [hashtable]
        $AdditionalProperties,

        # Set this flag to indicate the remote issue is resolved (it will show with a strikethrough)
        [Parameter(Position=2)]
        [switch]
        $Resolved
    )
    process {
        $status = @{}
        if($PSBoundParameters.ContainsKey("Icon")){$status.Add("icon",$Icon)}
        if($PSBoundParameters.ContainsKey("AdditionalProperties")){$status += $AdditionalProperties}
        if($PSBoundParameters.ContainsKey("Resolved")){$status.Add("resolved",$true)}

        $status
    }
}