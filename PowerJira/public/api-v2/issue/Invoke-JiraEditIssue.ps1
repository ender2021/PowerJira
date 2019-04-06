#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-put
function Invoke-JiraEditIssue {
    [CmdletBinding()]
    param (
        # The ID or Key of the issue to edit
        [Parameter(Mandatory,Position=0)]
        [string]
        $IssueIdOrKey,

        # Used to make simple updates to fields on this issue
        [Parameter(Position=1)]
        [hashtable]
        $Fields,

        # Used to make complex updates to issue fields
        [Parameter(Position=2)]
        [hashtable]
        $Update,

        # Optional history metadata
        [Parameter(Position=3)]
        [hashtable]
        $HistoryMetadata,

        # Add/set arbitrary issue properties
        [Parameter(Position=4)]
        [hashtable]
        $Properties,

        # DDisables issue notifications for this update
        [Parameter(Position=5)]
        [Switch]
        $DisableNotifications,

        # The JiraConnection object to use for the request
        [Parameter(Position=6)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issue/$IssueIdOrKey"
        $verb = "PUT"

        $query = @{}
        if($PSBoundParameters.ContainsKey("DisableNotifications")){$body.Add("notifyUsers",$false  )}

        $body=@{}
        if($PSBoundParameters.ContainsKey("Fields")){$body.Add("fields",$Fields)}
        if($PSBoundParameters.ContainsKey("Update")){$body.Add("update",$Update)}
        if($PSBoundParameters.ContainsKey("HistoryMetadata")){$body.Add("historyMetadata",$HistoryMetadata)}
        if($PSBoundParameters.ContainsKey("Properties")){$body.Add("properties",$Properties)}

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod $verb -QueryParams $query -Body $body
    }
}