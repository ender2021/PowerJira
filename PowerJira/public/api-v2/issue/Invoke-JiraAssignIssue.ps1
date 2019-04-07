#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-assignee-put
function Invoke-JiraAssignIssue {
    [CmdletBinding(DefaultParameterSetName="Assignee")]
    param (
        # The Key or ID of the issue
        [Parameter(Mandatory,Position=0)]
        [string]
        $IssueIdOrKey,

        # The account ID of the user to assign
        [Parameter(Mandatory,Position=1,ParameterSetName="Assignee")]
        [string]
        $AssigneeAccountId,

        # Set this flag to unassign this issue
        [Parameter(Mandatory,Position=1,ParameterSetName="Unassign")]
        [switch]
        $Unassign,

        # Set this flag to assign the issue to the default assignee for the project
        [Parameter(Mandatory,Position=1,ParameterSetName="ProjectDefault")]
        [switch]
        $ProjectDefault,

        # The JiraConnection object to use for the request
        [Parameter(Position=2)]
        [hashtable]
        $JiraConnection
    )
    
    process {
        $functionPath = "/rest/api/2/issue/$IssueIdOrKey/assignee"
        $verb = "PUT"

        $body=@{}
        if($PSBoundParameters.ContainsKey("AssigneeAccountId")){$body.Add("accountId",$AssigneeAccountId)}
        if($PSBoundParameters.ContainsKey("Unassign")){$body.Add("accountId",$null)}
        if($PSBoundParameters.ContainsKey("ProjectDefault")){$body.Add("accountId","-1")}

        Invoke-JiraRestRequest $JiraConnection $functionPath $verb -Body $body
    }
}