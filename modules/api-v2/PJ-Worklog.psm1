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

Export-ModuleMember -Function * -Variable *