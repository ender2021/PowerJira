#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-get
function Invoke-JiraGetIssue {
    [CmdletBinding()]
    param (
        # The ID or Key of the issue
        [Parameter(Mandatory=$true)]
        [string]
        $IssueIdOrKey,

        # Returns field values rendered in HTML format.
        [Parameter(Mandatory=$false)]
        [Switch]
        $ExpandRenderedFields,

        # Returns the display name of each field.
        [Parameter(Mandatory=$false)]
        [Switch]
        $ExpandNames,

        # Returns the schema describing a field type.
        [Parameter(Mandatory=$false)]
        [Switch]
        $ExpandSchema,

        # Returns all possible transitions for the issue.
        [Parameter(Mandatory=$false)]
        [Switch]
        $ExpandTransitions,

        # Returns all possible operations for the issue.
        [Parameter(Mandatory=$false)]
        [Switch]
        $ExpandOperations,

        # Returns information about how each field can be edited.
        [Parameter(Mandatory=$false)]
        [Switch]
        $ExpandEditMetadata,

        # Returns a list of recent updates to an issue, sorted by date, starting from the most recent.
        [Parameter(Mandatory=$false)]
        [Switch]
        $ExpandChangelog,

        # Instead of fields, returns versionedRepresentations a JSON array containing each version of a field's value, with the highest numbered item representing the most recent version.
        [Parameter(Mandatory=$false)]
        [Switch]
        $ExpandVersionedRepresentations,

        # The JiraConnection object to use for the request
        [Parameter(Mandatory=$false)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issue/$IssueIdOrKey"

        $expand = @()
        if($PSBoundParameters.ContainsKey("ExpandRenderedFields")){$expand += "renderedFields"} 
        if($PSBoundParameters.ContainsKey("ExpandNames")){$expand += "names"}
        if($PSBoundParameters.ContainsKey("ExpandSchema")){$expand += "schema"}
        if($PSBoundParameters.ContainsKey("ExpandTransitions")){$expand += "transitions"}
        if($PSBoundParameters.ContainsKey("ExpandOperations")){$expand += "operations"}
        if($PSBoundParameters.ContainsKey("ExpandEditMetadata")){$expand += "editmeta"}
        if($PSBoundParameters.ContainsKey("ExpandVersionedRepresentations")){$expand += "versionedRepresentations"}
        
        $body = @{}
        if($expand.Count -gt 0) {$body.Add("expand",$expand -join ",")}
        
        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "GET" -Body $body
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

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-editmeta-get
function Invoke-JiraGetIssueEditMetadata {
    [CmdletBinding()]
    param (
        # IDs of projects to return metadata for
        [Parameter(Mandatory=$true)]
        [string]
        $IssueIdOrKey,
        
        # The JiraConnection object to use for the request
        [Parameter(Mandatory=$false)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issue/$IssueIdOrKey/editmeta"
        
        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "GET"
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

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "POST" -Body $body
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
        if($PSBoundParameters.ContainsKey("Fields")){$body.Add("fields",$Fields)}
        if($PSBoundParameters.ContainsKey("Update")){$body.Add("update",$Update)}
        if($PSBoundParameters.ContainsKey("HistoryMetadata")){$body.Add("historyMetadata",$HistoryMetadata)}
        if($PSBoundParameters.ContainsKey("Properties")){$body.Add("properties",$Properties)}

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "PUT" -Body $body
    }
}

function Invoke-JiraTransitionIssue {
    [CmdletBinding()]
    param (
        # The ID or Key of the issue to edit
        [Parameter(Mandatory=$true)]
        [string]
        $IssueIdOrKey,

        # ID of a Transition to apply
        [Parameter(Mandatory=$true)]
        [int32]
        $TransitionId,

        # DDisables issue notifications for this update
        [Parameter(Mandatory=$false)]
        [Switch]
        $DisableNotifications,

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
        $functionPath = "/rest/api/2/issue/$IssueIdOrKey/transitions"

        $body=@{
            transition=@{id="$TransitionId"}
        }
        if($PSBoundParameters.ContainsKey("DisableNotifications")){$body.Add("notifyUsers",$false)}
        if($PSBoundParameters.ContainsKey("Fields")){$body.Add("fields",$Fields)}
        if($PSBoundParameters.ContainsKey("Update")){$body.Add("update",$Update)}
        if($PSBoundParameters.ContainsKey("HistoryMetadata")){$body.Add("historyMetadata",$HistoryMetadata)}
        if($PSBoundParameters.ContainsKey("Properties")){$body.Add("properties",$Properties)}

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "POST" -Body $body
    }
}

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

        $body=@{}
        if($PSBoundParameters.ContainsKey("AssigneeAccountId")){$body.Add("accountId",$AssigneeAccountId)}
        if($PSBoundParameters.ContainsKey("Unassign")){$body.Add("accountId",$null)}
        if($PSBoundParameters.ContainsKey("ProjectDefault")){$body.Add("accountId","-1")}

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "PUT" -Body $body
    }
}

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-comment-post
function Invoke-JiraAddComment {
    [CmdletBinding(DefaultParameterSetName="Role")]
    param (
        # The issue Id or Key
        [Parameter(Mandatory,Position=0)]
        [string]
        $IssueIdOrKey,

        # The comment body
        [Parameter(Mandatory,Position=1)]
        [string]
        $CommentBody,

        # Set this flag to expand the comment body in the response
        [Parameter(Position=2)]
        [switch]
        $ExpandRenderedBody,

        # Set this value to restrict the comment visibility to a project role
        [Parameter(ParameterSetName="Role",Position=3)]
        [string]
        $SetRoleVisibility,

        # Set this value to restrict the comment visibility to a group
        [Parameter(ParameterSetName="Group",Position=4)]
        [string]
        $SetGroupVisibility,

        # Set this flag to hide this comment in Jira Service Desk
        [Parameter(Position=5)]
        [switch]
        $JsdHide,

        # Additional properties to add to the comment object
        [Parameter(Position=6)]
        [hashtable[]]
        $Properties,

        # The JiraConnection object to use for the request
        [Parameter(Position=7)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issue/$IssueIdOrKey/comment"

        #remove this line if Atlassian ever fixes this
        if($PSBoundParameters.ContainsKey("SetGroupVisibility")){throw "Restricting comment visibility by group is currently broken in the Jira API"}

        $body=@{
            body = $CommentBody
        }
        if($PSBoundParameters.ContainsKey("ExpandRenderedBody")){$body.Add("expand","renderedBody")}
        if($PSBoundParameters.ContainsKey("SetRoleVisibility")){$body.Add("visibility",@{type="role";value="$SetRoleVisibility"})}
        if($PSBoundParameters.ContainsKey("SetGroupVisibility")){$body.Add("visibility",@{type="group";value="$SetGroupVisibility"})}
        if($PSBoundParameters.ContainsKey("JsdHide")){$body.Add("jsdPublic",$false)}
        if($PSBoundParameters.ContainsKey("Properties")){$body.Add("properties",$Properties)}

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "POST" -Body $body
    }
}

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-worklog-post
function Invoke-JiraAddWorklog {
    [CmdletBinding(DefaultParameterSetName="TimeSpent")]
    param (
        # The issue Id or Key
        [Parameter(Mandatory,Position=0)]
        [string]
        $IssueIdOrKey,

        # Time spent, using Jira's time notation format (e.g. 2h30m)
        [Parameter(Mandatory,ParameterSetName="TimeSpent",Position=1)]
        [Parameter(Mandatory,ParameterSetName="TimeSpent,new",Position=1)]
        [Parameter(Mandatory,ParameterSetName="TimeSpent,new,GroupVisibility",Position=1)]
        [Parameter(Mandatory,ParameterSetName="TimeSpent,new,RoleVisibility",Position=1)]
        [Parameter(Mandatory,ParameterSetName="TimeSpent,manual",Position=1)]
        [Parameter(Mandatory,ParameterSetName="TimeSpent,manual,GroupVisibility",Position=1)]
        [Parameter(Mandatory,ParameterSetName="TimeSpent,manual,RoleVisibility",Position=1)]
        [Parameter(Mandatory,ParameterSetName="TimeSpent,GroupVisibility",Position=1)]
        [Parameter(Mandatory,ParameterSetName="TimeSpent,RoleVisibility",Position=1)]
        [string]
        $TimeSpent,

        # Time spent in seconds, represented as an integer
        [Parameter(Mandatory,ParameterSetName="TimeSpentSeconds",Position=1)]
        [Parameter(Mandatory,ParameterSetName="TimeSpentSeconds,new",Position=1)]
        [Parameter(Mandatory,ParameterSetName="TimeSpentSeconds,new,GroupVisibility",Position=1)]
        [Parameter(Mandatory,ParameterSetName="TimeSpentSeconds,new,RoleVisibility",Position=1)]
        [Parameter(Mandatory,ParameterSetName="TimeSpentSeconds,manual",Position=1)]
        [Parameter(Mandatory,ParameterSetName="TimeSpentSeconds,manual,GroupVisibility",Position=1)]
        [Parameter(Mandatory,ParameterSetName="TimeSpentSeconds,manual,RoleVisibility",Position=1)]
        [Parameter(Mandatory,ParameterSetName="TimeSpentSeconds,GroupVisibility",Position=1)]
        [Parameter(Mandatory,ParameterSetName="TimeSpentSeconds,RoleVisibility",Position=1)]
        [int64]
        $TimeSpentSeconds,

        # The comment to add to the worklog
        [Parameter(Position=2)]
        [string]
        $Comment,

        # Controls how the remaining time estimate will be affected
        [Parameter(Position=3)]
        [ValidateSet("new","leave","manual","auto")]
        [string]
        $AdjustMethod,

        # Sets the new remaining estimate
        [Parameter(Mandatory,ParameterSetName="TimeSpent,new",Position=4)]
        [Parameter(Mandatory,ParameterSetName="TimeSpent,new,RoleVisibility",Position=4)]
        [Parameter(Mandatory,ParameterSetName="TimeSpent,new,GroupVisibility",Position=4)]
        [Parameter(Mandatory,ParameterSetName="TimeSpentSeconds,new",Position=4)]
        [Parameter(Mandatory,ParameterSetName="TimeSpentSeconds,new,RoleVisibility",Position=4)]
        [Parameter(Mandatory,ParameterSetName="TimeSpentSeconds,new,GroupVisibility",Position=4)]
        [string]
        $NewEstimate,

        # Amount to reduce the existing estimate by
        [Parameter(Mandatory,ParameterSetName="TimeSpent,manual",Position=4)]
        [Parameter(Mandatory,ParameterSetName="TimeSpent,manual,RoleVisibility",Position=4)]
        [Parameter(Mandatory,ParameterSetName="TimeSpent,manual,GroupVisibility",Position=4)]
        [Parameter(Mandatory,ParameterSetName="TimeSpentSeconds,manual",Position=4)]
        [Parameter(Mandatory,ParameterSetName="TimeSpentSeconds,manual,RoleVisibility",Position=4)]
        [Parameter(Mandatory,ParameterSetName="TimeSpentSeconds,manual,GroupVisibility",Position=4)]
        [string]
        $ReduceBy,

        # Date/time the work was started
        [Parameter(Position=5)]
        [datetime]
        $Started=(Get-Date),
        
        # Set this flag to disable notifications
        [Parameter(Position=6)]
        [switch]
        $DisableNotifications,

        # Expands the properties in the returned worklog object
        [Parameter(Position=7)]
        [switch]
        $ExpandProperties,

        # Set this value to restrict the comment visibility to a project role
        [Parameter(Mandatory,ParameterSetName="TimeSpent,RoleVisibility",Position=8)]
        [Parameter(Mandatory,ParameterSetName="TimeSpent,new,RoleVisibility",Position=8)]
        [Parameter(Mandatory,ParameterSetName="TimeSpent,manual,RoleVisibility",Position=8)]
        [Parameter(Mandatory,ParameterSetName="TimeSpentSeconds,new,RoleVisibility",Position=8)]
        [Parameter(Mandatory,ParameterSetName="TimeSpentSeconds,manual,RoleVisibility",Position=8)]
        [Parameter(Mandatory,ParameterSetName="TimeSpentSeconds,RoleVisibility",Position=8)]
        [string]
        $SetRoleVisibility,

        # Set this value to restrict the comment visibility to a group
        [Parameter(Mandatory,ParameterSetName="TimeSpent,GroupVisibility",Position=8)]
        [Parameter(Mandatory,ParameterSetName="TimeSpent,new,GroupVisibility",Position=8)]
        [Parameter(Mandatory,ParameterSetName="TimeSpent,manual,GroupVisibility",Position=8)]
        [Parameter(Mandatory,ParameterSetName="TimeSpentSeconds,new,GroupVisibility",Position=8)]
        [Parameter(Mandatory,ParameterSetName="TimeSpentSeconds,manual,GroupVisibility",Position=8)]
        [Parameter(Mandatory,ParameterSetName="TimeSpentSeconds,GroupVisibility",Position=8)]
        [string]
        $SetGroupVisibility,

        # Additional properties to add to the comment object
        [Parameter(Position=9)]
        [hashtable[]]
        $Properties,

        # The JiraConnection object to use for the request
        [Parameter(Position=10)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issue/$IssueIdOrKey/worklog"

        $body=@{
            started = (Format-JiraRestDateTime $Started)
        }
        if($PSBoundParameters.ContainsKey("TimeSpent")){$body.Add("timeSpent",$TimeSpent)}
        if($PSBoundParameters.ContainsKey("TimeSpentSeconds")){$body.Add("timeSpentSeconds",$TimeSpentSeconds)}
        if($PSBoundParameters.ContainsKey("Comment")){$body.Add("comment",$Comment)}
        if($PSBoundParameters.ContainsKey("AdjustMethod")){$body.Add("adjustEstimate",$AdjustMethod)}
        if($PSBoundParameters.ContainsKey("NewEstimate")){$body.Add("newEstimate",$NewEstimate)}
        if($PSBoundParameters.ContainsKey("ReduceBy")){$body.Add("reduceBy",$ReduceBy)}
        if($PSBoundParameters.ContainsKey("DisableNotifications")){$body.Add("notifyUsers",$false)}
        if($PSBoundParameters.ContainsKey("ExpandProperties")){$body.Add("expand","properties")}
        if($PSBoundParameters.ContainsKey("SetRoleVisibility")){$body.Add("visibility",@{type="role";value="$SetRoleVisibility"})}
        if($PSBoundParameters.ContainsKey("SetGroupVisibility")){$body.Add("visibility",@{type="group";value="$SetGroupVisibility"})}
        if($PSBoundParameters.ContainsKey("Properties")){$body.Add("properties",$Properties)}
        
        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "POST" -Body $body
    }
}

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-watchers-post
function Invoke-JiraAddWatcher {
    [CmdletBinding()]
    param (
        # The issue Id or Key
        [Parameter(Mandatory,Position=0)]
        [string]
        $IssueIdOrKey,

        # The account ID of the user to add
        [Parameter(Position=1)]
        [string]
        $AccountId,

        # The JiraConnection object to use for the request
        [Parameter(Position=2)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issue/$IssueIdOrKey/watchers"

        $body=""
        if($PSBoundParameters.ContainsKey("AccountId")){$body = """$AccountId"""}

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "POST" -LiteralBody $body
    }
}

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-watchers-get
#
function Invoke-JiraGetIssueWatchers {
    [CmdletBinding()]
    param (
        # The issue Id or Key
        [Parameter(Mandatory,Position=0)]
        [string]
        $IssueIdOrKey,

        # The JiraConnection object to use for the request
        [Parameter()]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issue/$IssueIdOrKey/watchers"

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "GET"
    }
}

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

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-bulk-post
function Invoke-JiraCreateIssueBulk {
    [CmdletBinding()]
    param (
        # An array of hashtables containing instructions for setting fields and updating the issues
        [Parameter(Mandatory,Position=0)]
        [hashtable[]]
        $Issues,

        # The JiraConnection object to use for the request
        [Parameter(Position=1)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issue/bulk"

        $body=@{issueUpdates=$Issues}

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "POST" -Body $body
    }
}

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-attachments-post
function Invoke-JiraAddAttachment {
    [CmdletBinding()]
    param (
        # The issue Id or Key
        [Parameter(Mandatory,Position=0)]
        [string]
        $IssueIdOrKey,

        # Attachment file object (use the output of a Get-Item call)
        [Parameter(Mandatory,Position=1)]
        [object]
        $Attachment,

        # The JiraConnection object to use for the request
        [Parameter()]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issue/$issueIdOrKey/attachments"

        $form = @{file=$Attachment}

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "POST" -Multipart -Form $form
    }
}

Export-ModuleMember -Function * -Variable *