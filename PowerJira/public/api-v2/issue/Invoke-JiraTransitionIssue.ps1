#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-transitions-post
function Invoke-JiraTransitionIssue {
    [CmdletBinding()]
    param (
        # The ID or Key of the issue to edit
        [Parameter(Mandatory,Position=0)]
        [string]
        $IssueIdOrKey,

        # ID of a Transition to apply
        [Parameter(Mandatory,Position=1)]
        [int32]
        $TransitionId,

        # DDisables issue notifications for this update
        [Parameter(Position=2)]
        [Switch]
        $DisableNotifications,

        # Used to make simple updates to fields on this issue
        [Parameter(Position=3)]
        [hashtable]
        $Fields,

        # Used to make complex updates to issue fields
        [Parameter(Position=4)]
        [hashtable]
        $Update,

        # Optional history metadata
        [Parameter(Position=5)]
        [hashtable]
        $HistoryMetadata,

        # Add/set arbitrary issue properties
        [Parameter(Position=6)]
        [hashtable]
        $Properties,

        # The JiraConnection object to use for the request
        [Parameter(Position=7)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issue/$IssueIdOrKey/transitions"
        $verb = "POST"

        $body=@{
            transition=@{id="$TransitionId"}
        }
        if($PSBoundParameters.ContainsKey("DisableNotifications")){$body.Add("notifyUsers",$false)}
        if($PSBoundParameters.ContainsKey("Fields")){$body.Add("fields",$Fields)}
        if($PSBoundParameters.ContainsKey("Update")){$body.Add("update",$Update)}
        if($PSBoundParameters.ContainsKey("HistoryMetadata")){$body.Add("historyMetadata",$HistoryMetadata)}
        if($PSBoundParameters.ContainsKey("Properties")){$body.Add("properties",$Properties)}

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Body $body
    }
}