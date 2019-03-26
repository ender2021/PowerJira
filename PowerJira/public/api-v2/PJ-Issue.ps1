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

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-watchers-delete
function Invoke-JiraDeleteWatcher {
    [CmdletBinding()]
    param (
        # The issue Id or Key
        [Parameter(Mandatory,Position=0)]
        [string]
        $IssueIdOrKey,

        # The account ID of the watcher to delete
        [Parameter(Mandatory,Position=1)]
        [string]
        $WatcherAccountId,

        # The JiraConnection object to use for the request
        [Parameter(Position=2)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issue/$IssueIdOrKey/watchers"

        $body=@{
            accountId = $WatcherAccountId
        }

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "DELETE" -Body $body
    }
}

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-votes-get
function Invoke-JiraGetVotes {
    [CmdletBinding()]
    param (
        # The issue Id or Key
        [Parameter(Mandatory,Position=0)]
        [string]
        $IssueIdOrKey,

        # The JiraConnection object to use for the request
        [Parameter(Position=1)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issue/$IssueIdOrKey/votes"

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "GET"
    }
}

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-votes-post
function Invoke-JiraAddVote {
    [CmdletBinding()]
    param (
        # The issue Id or Key
        [Parameter(Mandatory,Position=0)]
        [string]
        $IssueIdOrKey,

        # The JiraConnection object to use for the request
        [Parameter(Position=1)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issue/$IssueIdOrKey/votes"

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "POST"
    }
}

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-votes-delete
function Invoke-JiraDeleteVote {
    [CmdletBinding()]
    param (
        # The issue Id or Key
        [Parameter(Mandatory,Position=0)]
        [string]
        $IssueIdOrKey,

        # The JiraConnection object to use for the request
        [Parameter(Position=1)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issue/$IssueIdOrKey/votes"

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "DELETE"
    }
}

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-notify-post
function Invoke-JiraSendIssueNotification {
    [CmdletBinding(DefaultParameterSetName="SkipAll")]
    param (
        # The issue Id or Key
        [Parameter(Mandatory,Position=0)]
        [string]
        $IssueIdOrKey,

        # The body of the email
        [Parameter(Mandatory,Position=1)]
        [string]
        $PlainBody,

        # The body of the email
        [Parameter(Position=2)]
        [string]
        $HtmlBody,

        # The email subject line
        [Parameter(Position=3)]
        [string]
        $Subject,

        # A list of accountIds for users to notify
        [Parameter(Position=4)]
        [string[]]
        $Users,

        # A list of names for groups to notify
        [Parameter(Position=5)]
        [string[]]
        $Groups,

        # A list of groups that a user must belong to in order to receive a notification
        [Parameter(Position=6)]
        [string[]]
        $RestrictGroups,

        # A list of IDs of permissions a user must have in order to receive a notification
        [Parameter(Position=7)]
        [hashtable[]]
        $RestrictPermissions,

        # Set this flag to skip notifying the issue reporter
        [Parameter(ParameterSetName="SkipSome")]
        [switch]
        $SkipReporter,

        # Set this flag to skip notifying the issue assignee
        [Parameter(ParameterSetName="SkipSome")]
        [switch]
        $SkipAssignee,

        # Set this flag to skip notifying the issue voters
        [Parameter(ParameterSetName="SkipSome")]
        [switch]
        $SkipVoters,

        # Set this flag to skip notifying the issue watchers
        [Parameter(ParameterSetName="SkipSome")]
        [switch]
        $SkipWatchers,

        # Set this flag to skip notifying the issue reporter, assignee, voters, and watchers
        [Parameter(ParameterSetName="SkipAll")]
        [switch]
        $SkipAllDefault,

        # The JiraConnection object to use for the request
        [Parameter()]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issue/$IssueIdOrKey/notify"

        $to = @{
            reporter = $true
            assignee = $true
            voters = $true
            watchers = $true
        }
        if($PSBoundParameters.ContainsKey("SkipAllDefault")) {
            $to.reporter = $false
            $to.assignee = $false
            $to.voters = $false
            $to.watchers = $false
        } else {
            if($PSBoundParameters.ContainsKey("SkipReporter")){$to.reporter=$false}
            if($PSBoundParameters.ContainsKey("SkipAssignee")){$to.assignee=$false}
            if($PSBoundParameters.ContainsKey("SkipVoters")){$to.voters=$false}
            if($PSBoundParameters.ContainsKey("SkipWatchers")){$to.watchers=$false}
        }
        if($PSBoundParameters.ContainsKey("Users")){
            $to.Add("users",@())
            $Users | ForEach-Object {$to.users += @{name=$_}}
        }
        if($PSBoundParameters.ContainsKey("Groups")){
            $to.Add("groups",@())
            $Groups | ForEach-Object {$to.groups += @{name=$_}}
        }

        $restrict = @{
            groups = @()
            permissions = @()
        }
        if($PSBoundParameters.ContainsKey("RestrictGroups")){$RestrictGroups | ForEach-Object {$restrict.groups += @{name=$_}}}
        if($PSBoundParameters.ContainsKey("RestrictPermissions")){$restrict.permissions += $RestrictPermissions}

        $body=@{
            textBody = $PlainBody
            to = $to
        }
        if($PSBoundParameters.ContainsKey("HtmlBody")){$body.Add("htmlBody",$HtmlBody)}
        if($PSBoundParameters.ContainsKey("Subject")){$body.Add("subject",$Subject)}
        if(($restrict.groups.Count -gt 0) -or ($restrict.permissions.Count -gt 0)) {$body.Add("restrict",$restrict)}

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "POST" -Body $body -BodyDepth 5
    }
}

Export-ModuleMember -Function * -Variable *