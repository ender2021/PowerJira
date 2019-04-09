function New-JiraRemoteObject {
    [CmdletBinding()]
    param (
        # The URL of the object
        [Parameter(Mandatory,Position=0)]
        [string]
        $Url,

        # The title of the remote object
        [Parameter(Mandatory,Position=1)]
        [string]
        $Title,

        # The sumary of the object
        [Parameter(Position=2)]
        [string]
        $Summary,

        # A Jira icon object to associate with the remote object. Use New-JiraRemoteLinkIcon
        [Parameter(Position=3)]
        [hashtable]
        $Icon,

        # A Jira status object to associate with the remote object. Use New-JiraRemoteLinkStatus
        [Parameter(Position=4)]
        [hashtable]
        $Status
    )
    process {
        $ro = @{
            url = $Url
            title = $Title
        }
        if($PSBoundParameters.ContainsKey("Summary")){$ro.Add("summary",$Summary)}
        if($PSBoundParameters.ContainsKey("Icon")){$ro.Add("icon",$Icon)}
        if($PSBoundParameters.ContainsKey("Status")){$ro.Add("status",$Status)}

        $ro
    }
}