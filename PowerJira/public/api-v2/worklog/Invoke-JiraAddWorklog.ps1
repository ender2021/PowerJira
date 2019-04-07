$JiraWorklogExpand = @("properties")

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
        [Parameter(Mandatory,ParameterSetName="TimeSpent,manual",Position=1)]
        [string]
        $TimeSpent,

        # Time spent in seconds, represented as an integer
        [Parameter(Mandatory,ParameterSetName="TimeSpentSeconds",Position=1)]
        [Parameter(Mandatory,ParameterSetName="TimeSpentSeconds,new",Position=1)]
        [Parameter(Mandatory,ParameterSetName="TimeSpentSeconds,manual",Position=1)]
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
        $AdjustMethod="auto",

        # Sets the new remaining estimate
        [Parameter(Mandatory,ParameterSetName="TimeSpent,new",Position=4)]
        [Parameter(Mandatory,ParameterSetName="TimeSpentSeconds,new",Position=4)]
        [string]
        $NewEstimate,

        # Amount to reduce the existing estimate by
        [Parameter(Mandatory,ParameterSetName="TimeSpent,manual",Position=4)]
        [Parameter(Mandatory,ParameterSetName="TimeSpentSeconds,manual",Position=4)]
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

        # Used to expand additional attributes
        [Parameter(Position=7)]
        [ValidateScript({ Compare-StringArraySubset $JiraWorklogExpand $_ })]
        [string[]]
        $Expand,

        # Set the visibility of the worklog.  Use New-JiraWorklogVisiblity
        [Parameter(Position=8)]
        [hashtable]
        $Visibility,

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
        $verb = "POST"

        $query = @{
            adjustEstimate = $AdjustMethod
            notifyUsers = $true
        }
        if($PSBoundParameters.ContainsKey("NewEstimate")){$query.Add("newEstimate",$NewEstimate)}
        if($PSBoundParameters.ContainsKey("DisableNotifications")){$query.notifyUsers = $false}
        if($PSBoundParameters.ContainsKey("Expand")){$query.Add("expand",$Expand -join ",")}
        if($PSBoundParameters.ContainsKey("ReduceBy")){$query.Add("reduceBy",$ReduceBy)}

        $body=@{
            started = (Format-JiraRestDateTime $Started)
        }
        if($PSBoundParameters.ContainsKey("TimeSpent")){$body.Add("timeSpent",$TimeSpent)}
        if($PSBoundParameters.ContainsKey("TimeSpentSeconds")){$body.Add("timeSpentSeconds",$TimeSpentSeconds)}
        if($PSBoundParameters.ContainsKey("Comment")){$body.Add("comment",$Comment)}
        if($PSBoundParameters.ContainsKey("Visibility")){$body.Add("visibility",$Visibility)}
        if($PSBoundParameters.ContainsKey("Properties")){$body.Add("properties",$Properties)}
        
        Invoke-JiraRestRequest $JiraConnection $functionPath $verb -Body $body -Query $query
    }
}