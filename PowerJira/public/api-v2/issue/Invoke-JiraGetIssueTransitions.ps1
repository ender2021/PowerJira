#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-transitions-get
function Invoke-JiraGetIssueTransitions {
    [CmdletBinding()]
    param (
        # The issue Id or Key
        [Parameter(Mandatory,Position=0)]
        [string]
        $IssueIdOrKey,

        # Set this flag to expand transition field information
        [Parameter(Position=1)]
        [switch]
        $ExpandFields,

        # Set this to retrieve a specfic transition by ID
        [Parameter(Position=2)]
        [int32]
        $TransitionId,

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

        $body=@{}
        if($PSBoundParameters.ContainsKey("ExpandFields")){$body.Add("expand","transitions.fields")}
        if($PSBoundParameters.ContainsKey("TransitionId")){$body.Add("transitionId",$TransitionId)}
        if($PSBoundParameters.ContainsKey("SkipHidden")){$body.Add("skipRemoteOnlyCondition",$true)}

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "GET" -Body $body
    }
}