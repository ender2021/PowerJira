#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-get
function Invoke-JiraGetIssue {
    [CmdletBinding()]
    param (
        # The ID or Key of the issue
        [Parameter(Mandatory=$true)]
        [string]
        $IssueIdOrKey,

        # The JiraConnection object to use for the request
        [Parameter(Mandatory=$false)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issue/$IssueIdOrKey"

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "GET"
    }
}

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-createmeta-get
function Invoke-JiraGetIssueCreateMetadata {
    [CmdletBinding()]
    param (
        # IDs of projects to return metadata for
        [Parameter(Mandatory=$false)]
        [int32[]]
        $ProjectIds,

        # Keys of projcts to return metadata for
        [Parameter(Mandatory=$false)]
        [string[]]
        $ProjectKeys,

        # IDs of issue types to return metadata for
        [Parameter(Mandatory=$false)]
        [int32[]]
        $IssueTypeIds,

        # Names of issue types to return metadata for
        [Parameter(Mandatory=$false)]
        [string[]]
        $IssueTypeNames,

        # Expand additional properties
        [Parameter(Mandatory=$false)]
        [Switch]
        $ExpandFields,

        # The JiraConnection object to use for the request
        [Parameter(Mandatory=$false)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issue/createmeta"
        
        $body = @{}
        if($PSBoundParameters.ContainsKey("ProjectIds")){$body.Add("projectIds",$ProjectIds -join ",")}
        if($PSBoundParameters.ContainsKey("ProjectKeys")){$body.Add("projectKeys",$ProjectKeys -join ",")}
        if($PSBoundParameters.ContainsKey("IssueTypeIds")){$body.Add("issuetypeIds",$IssueTypeIds -join ",")}
        if($PSBoundParameters.ContainsKey("IssueTypeNames")){$body.Add("issuetypeNames",$IssueTypeNames  -join ",")}
        if($PSBoundParameters.ContainsKey("ExpandFields")){$body.Add("expand","projects.issuetypes.fields  ")}

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "GET" -Body $body
    }
}

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-post
function Invoke-JiraCreateIssue {
    [CmdletBinding()]
    param (
        # Indicates whether the creating user's history should be updated to show the project the issue is created in
        [Parameter(Mandatory=$false)]
        [Switch]
        $UpdateUserHistory,

        # DDisables issue notifications for this update
        [Parameter(Mandatory=$false)]
        [Switch]
        $DisableNotifications,

        # ID of a Transition to apply
        [Parameter(Mandatory=$false)]
        [int32]
        $TransitionId,

        # Used to make simple updates to fields on this issue
        [Parameter(Mandatory=$false)]
        [hashtable]
        $Fields,

        # Used to make complex updates to issue fields
        [Parameter(Mandatory=$false)]
        [hashtable]
        $Update,

        # Optional history metadata
        [Parameter(Mandatory=$false)]
        [hashtable]
        $HistoryMetadata,

        # Add/set arbitrary issue properties
        [Parameter(Mandatory=$false)]
        [hashtable]
        $Properties,

        # The JiraConnection object to use for the request
        [Parameter(Mandatory=$false)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issue"

        $body=@{}
        if($PSBoundParameters.ContainsKey("UpdateUserHistory")){$body.Add("updateHistory",$true)}
        if($PSBoundParameters.ContainsKey("DisableNotifications")){$body.Add("notifyUsers",$false)}
        if($PSBoundParameters.ContainsKey("TransitionId")){$body.Add("transition",@{id="$TransitionId"})}
        if($PSBoundParameters.ContainsKey("Fields")){$body.Add("fields",$Fields)}
        if($PSBoundParameters.ContainsKey("Update")){$body.Add("update",$Update)}
        if($PSBoundParameters.ContainsKey("HistoryMetadata")){$body.Add("historyMetadata",$HistoryMetadata)}
        if($PSBoundParameters.ContainsKey("Properties")){$body.Add("properties",$Properties)}

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "POST"
    }
 }


 #https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-put
function Invoke-JiraEditIssue {
    [CmdletBinding()]
    param (
        # The ID or Key of the issue to edit
        [Parameter(Mandatory=$true)]
        [string]
        $IssueIdOrKey,

        # DDisables issue notifications for this update
        [Parameter(Mandatory=$false)]
        [Switch]
        $DisableNotifications,

        # ID of a Transition to apply
        [Parameter(Mandatory=$false)]
        [int32]
        $TransitionId,

        # Used to make simple updates to fields on this issue
        [Parameter(Mandatory=$false)]
        [hashtable]
        $Fields,

        # Used to make complex updates to issue fields
        [Parameter(Mandatory=$false)]
        [hashtable]
        $Update,

        # Optional history metadata
        [Parameter(Mandatory=$false)]
        [hashtable]
        $HistoryMetadata,

        # Add/set arbitrary issue properties
        [Parameter(Mandatory=$false)]
        [hashtable]
        $Properties,

        # The JiraConnection object to use for the request
        [Parameter(Mandatory=$false)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issue/$IssueIdOrKey"

        $body=@{}
        if($PSBoundParameters.ContainsKey("DisableNotifications")){$body.Add("notifyUsers",$false)}
        if($PSBoundParameters.ContainsKey("TransitionId")){$body.Add("transition",@{id="$TransitionId"})}
        if($PSBoundParameters.ContainsKey("Fields")){$body.Add("fields",$Fields)}
        if($PSBoundParameters.ContainsKey("Update")){$body.Add("update",$Update)}
        if($PSBoundParameters.ContainsKey("HistoryMetadata")){$body.Add("historyMetadata",$HistoryMetadata)}
        if($PSBoundParameters.ContainsKey("Properties")){$body.Add("properties",$Properties)}

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "PUT"
    }
}

Export-ModuleMember -Function * -Variable *