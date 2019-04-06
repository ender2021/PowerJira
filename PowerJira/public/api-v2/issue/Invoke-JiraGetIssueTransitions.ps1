$JiraIssueTransitionsExpand = @("transitions.fields")

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-transitions-get
function Invoke-JiraGetIssueTransitions {
    [CmdletBinding()]
    param (
        # The issue Id or Key
        [Parameter(Mandatory,Position=0)]
        [string]
        $IssueIdOrKey,

        # Set this to retrieve a specfic transition by ID
        [Parameter(Position=1)]
        [int32]
        $TransitionId,

        # Used to expand additional attributes
        [Parameter(Position=2)]
        [ValidateScript({ Compare-StringArraySubset $JiraIssueTransitionsExpand $_ })]
        [string[]]
        $Expand,

        # Set this flag to skip retrieval of transitions hidden from users
        [Parameter(Position=3)]
        [switch]
        $SkipHidden,

        # The JiraConnection object to use for the request
        [Parameter(Position=4)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issue/$IssueIdOrKey/transitions"
        $verb = "GET"

        $query=@{}
        if($PSBoundParameters.ContainsKey("ExpandFields")){$query.Add("expand",$Expand -join ",")}
        if($PSBoundParameters.ContainsKey("TransitionId")){$query.Add("transitionId",$TransitionId)}
        if($PSBoundParameters.ContainsKey("SkipHidden")){$query.Add("skipRemoteOnlyCondition",$true)}

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod $verb -Query $query
    }
}