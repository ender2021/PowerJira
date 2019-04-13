function New-JiraRemoteLinkStatus {
    [CmdletBinding()]
    param (
        # A Jira icon object to associate with the remote object
        [Parameter(Position=0)]
        [ValidateScript({ (Compare-StringArraySubset @("url16x16";"title";"link") $_.Keys) -and ($_.Keys -contains "url16x16") -and ($_.Keys -contains "title") })]
        [hashtable]
        $Icon,

        # Set this flag to indicate the remote issue is resolved (it will show with a strikethrough)
        [Parameter(Position=1)]
        [switch]
        $Resolved
    )
    process {
        $status = @{}
        if($PSBoundParameters.ContainsKey("Icon")){$status.Add("icon",$Icon)}
        if($PSBoundParameters.ContainsKey("Resolved")){$status.Add("resolved",$true)}

        $status
    }
}