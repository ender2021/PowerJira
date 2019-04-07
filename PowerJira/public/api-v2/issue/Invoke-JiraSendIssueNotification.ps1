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
        $HtmlBody,

        # The body of the email
        [Parameter(Position=2)]
        [string]
        $PlainBody,

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
        $verb = "POST"

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
            htmlBody = $HtmlBody
            to = $to
        }
        if($PSBoundParameters.ContainsKey("PlainBody")){$body.Add("textBody",$PlainBody)}
        if($PSBoundParameters.ContainsKey("Subject")){$body.Add("subject",$Subject)}
        if(($restrict.groups.Count -gt 0) -or ($restrict.permissions.Count -gt 0)) {$body.Add("restrict",$restrict)}

        Invoke-JiraRestRequest $JiraConnection $functionPath $verb -Body $body -BodyDepth 5
    }
}