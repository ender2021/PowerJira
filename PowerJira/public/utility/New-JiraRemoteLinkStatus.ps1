function New-JiraRemoteLinkStatus {
    [CmdletBinding()]
    param (
        # A Jira icon object to associate with the remote object
        [Parameter(Position=0)]
        [ValidateScript({ ($_.Keys -contains "url16x16") -and ($_.Keys -contains "title") })]
        [hashtable]
        $Icon,

        # Set this flag to indicate the remote issue is resolved (it will show with a strikethrough)
        [Parameter(Position=1)]
        [switch]
        $Resolved
    )
    process {
        $status = @{
            resolved = $false
        }
        if($PSBoundParameters.ContainsKey("Icon")){$status.Add("icon",$Icon)}
        if($PSBoundParameters.ContainsKey("Resolved")){$status.resolved = $true}

        $status
    }
}