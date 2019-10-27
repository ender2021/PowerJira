#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-user-assignable-search-get
function Invoke-JiraGetUsersAssignableToIssues {
    [CmdletBinding(DefaultParameterSetName="Project")]
    param (
        # Specify a project key to determine users that can be assigned to new issues
        [Parameter(Mandatory,Position=0,ParameterSetName="Project")]
        [ValidateNotNullOrEmpty()]
        [string]
        $ProjectIdOrKey,

        # The issue Key
        [Parameter(Mandatory,Position=0,ParameterSetName="Issue")]
        [Parameter(Mandatory,Position=0,ParameterSetName="IssueTransition")]
        [ValidateNotNullOrEmpty()]
        [string]
        $IssueKey,

        # The ID of the transition being applied
        [Parameter(Mandatory,Position=1,ParameterSetName="IssueTransition")]
        [int64]
        $TransitionId,

        # A search filter for users to return
        [Parameter(Position=1,ParameterSetName="Project")]
        [Parameter(Position=1,ParameterSetName="Issue")]
        [Parameter(Position=2,ParameterSetName="IssueTransition")]
        [string]
        $Filter,

        # The index of the first item to return in the page of results (page offset). The base index is 0.
        [Parameter(Position=2,ParameterSetName="Project")]
        [Parameter(Position=2,ParameterSetName="Issue")]
        [Parameter(Position=3,ParameterSetName="IssueTransition")]
        [int32]
        $StartAt=0,

        # The maximum number of items to return per page. The default is 50 and the maximum is 1000.
        [Parameter(Position=3,ParameterSetName="Project")]
        [Parameter(Position=3,ParameterSetName="Issue")]
        [Parameter(Position=4,ParameterSetName="IssueTransition")]
        [ValidateRange(1,1000)]
        [int32]
        $MaxResults=50,

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "rest/api/2/user/assignable/search"
        $verb = "GET"

        $query = [RestMethodQueryParams]::new(@{
            startAt = $StartAt
            maxResults = $MaxResults
        })
        if($PSBoundParameters.ContainsKey("ProjectIdOrKey")){$query.Add("project",$ProjectIdOrKey)}
        if($PSBoundParameters.ContainsKey("IssueKey")){$query.Add("issueKey",$IssueKey)}
        if($PSBoundParameters.ContainsKey("TransitionId")){$query.Add("actionDescriptorId",$TransitionId)}
        if($PSBoundParameters.ContainsKey("Filter")){$query.Add("query",$Filter)}

        $method = [RestMethod]::new($functionPath,$verb,$query)
        $method.Invoke($JiraContext)
    }
}