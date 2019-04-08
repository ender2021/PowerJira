$NotificationSchemeExpand = @("all","field","group","notificationSchemeEvents","projectRole","user")

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-notificationscheme-get
function Invoke-JiraGetNotificationSchemesPaginated {
    [CmdletBinding()]
    param (
        # The index of the first item to return in the page of results (page offset). The base index is 0.
        [Parameter(Position=0)]
        [int64]
        $StartAt=0,

        # The maximum number of items to return per page. The default is 50 and the maximum is 50.
        [Parameter(Position=1)]
        [ValidateRange(1,50)]
        [int32]
        $MaxResults=50,

        # Select which fields on the returned object will be expanded
        [Parameter(Position=2)]
        [ValidateScript({ Compare-StringArraySubset $NotificationSchemeExpand $_ })]
        [string[]]
        $Expand,

        # The JiraConnection object to use for the request
        [Parameter(Position=3)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/notificationscheme"
        $verb = "GET"

        $query = @{
            startAt = $StartAt
            maxResults = $MaxResults
        }
        if($PSBoundParameters.ContainsKey("Expand")){$query.Add("expand",$Expand -join ",")}

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Query $query
    }
}