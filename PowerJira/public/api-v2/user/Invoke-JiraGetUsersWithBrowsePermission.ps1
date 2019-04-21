#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-user-viewissue-search-get
function Invoke-JiraGetUsersWithBrowsePermission {
    [CmdletBinding(DefaultParameterSetName="Project")]
    param (
        # A project key to set the context of the permissions
        [Parameter(Mandatory,Position=0,ParameterSetName="Project")]
        [ValidateNotNullOrEmpty()]
        [string]
        $ProjectKey,

        # An issue key to set the context of the permissions
        [Parameter(Mandatory,Position=0,ParameterSetName="Issue")]
        [ValidateNotNullOrEmpty()]
        [string]
        $IssueKey,

        # A search filter for users to return
        [Parameter(Mandatory,Position=1)]
        [string]
        $Filter,

        # The index of the first item to return in the page of results (page offset). The base index is 0.
        [Parameter(Position=2)]
        [int32]
        $StartAt=0,

        # The maximum number of items to return per page. The default is 50 and the maximum is 1000.
        [Parameter(Position=3)]
        [ValidateRange(1,1000)]
        [int32]
        $MaxResults=50,

        # The JiraConnection object to use for the request
        [Parameter(Position=4)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/user/viewissue/search"
        $verb = "GET"

        $query=@{
            startAt = $StartAt
            maxResults = $MaxResults
            query = $Filter
        }
        if($PSBoundParameters.ContainsKey("ProjectKey")){$query.Add("projectKey",$ProjectKey)}
        if($PSBoundParameters.ContainsKey("IssueKey")){$query.Add("issueKey",$IssueKey)}

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Query $query
    }
}