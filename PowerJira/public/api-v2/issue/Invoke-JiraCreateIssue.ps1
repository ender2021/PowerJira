#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-post
function Invoke-JiraCreateIssue {
    [CmdletBinding()]
    param (
        # Used to make simple updates to fields on this issue
        [Parameter(Position=0)]
        [hashtable]
        $Fields,

        # Used to make complex updates to issue fields
        [Parameter(Position=1)]
        [hashtable]
        $Update,

        # ID of a Transition to apply
        [Parameter(Position=2)]
        [int32]
        $TransitionId,

        # Optional history metadata
        [Parameter(Position=3)]
        [hashtable]
        $HistoryMetadata,

        # Add/set arbitrary issue properties
        [Parameter(Position=4)]
        [hashtable]
        $Properties,
        
        # Indicates whether the creating user's history should be updated to show the project the issue is created in
        [Parameter(Position=5)]
        [Switch]
        $UpdateUserHistory,

        # DDisables issue notifications for this update
        [Parameter(Position=6)]
        [Switch]
        $DisableNotifications,

        # The JiraConnection object to use for the request
        [Parameter(Position=7)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issue"
        $verb = "POST"

        $query = @{}
        if($PSBoundParameters.ContainsKey("UpdateUserHistory")){$body.Add("updateHistory",$true)}

        $body=@{}
        if($PSBoundParameters.ContainsKey("DisableNotifications")){$body.Add("notifyUsers",$false)}
        if($PSBoundParameters.ContainsKey("TransitionId")){$body.Add("transition",@{id="$TransitionId"})}
        if($PSBoundParameters.ContainsKey("Fields")){$body.Add("fields",$Fields)}
        if($PSBoundParameters.ContainsKey("Update")){$body.Add("update",$Update)}
        if($PSBoundParameters.ContainsKey("HistoryMetadata")){$body.Add("historyMetadata",$HistoryMetadata)}
        if($PSBoundParameters.ContainsKey("Properties")){$body.Add("properties",$Properties)}

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Query $query -Body $body
    }
 }