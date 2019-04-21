#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-user-picker-get
function Invoke-JiraGetUsersForPicker {
    [CmdletBinding()]
    param (
        # A search filter for users to return
        [Parameter(Mandatory,Position=0)]
        [string]
        $Filter,

        # A list of account IDs of users to exclude from the results
        [Parameter(Position=1)]
        [string[]]
        $Exclude,

        # The maximum number of items to return per page. The default is 50 and the maximum is 1000.
        [Parameter(Position=2)]
        [ValidateRange(1,1000)]
        [int32]
        $MaxResults=50,

        # Set this flag to return the user's avatar uri
        [Parameter()]
        [switch]
        $ShowAvatar,

        # Set this flag to exclude Connect users from results
        [Parameter()]
        [switch]
        $ExcludeConnect,

        # The JiraConnection object to use for the request
        [Parameter(Position=3)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/user/picker"
        $verb = "GET"

        $query=@{
            maxResults = $MaxResults
            query = $Filter
        }
        if($PSBoundParameters.ContainsKey("Exclude")){$query.Add("excludeAccountIds",$Exclude -join ",")}
        if($PSBoundParameters.ContainsKey("ShowAvatar")){$query.Add("showAvatar",$true)}
        if($PSBoundParameters.ContainsKey("ExcludeConnect")){$query.Add("excludeConnectUsers",$true)}

        (Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Query $query).users
    }
}