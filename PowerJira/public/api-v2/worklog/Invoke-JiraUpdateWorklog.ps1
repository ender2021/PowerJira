$JiraWorklogExpand = @("properties")

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-worklog-id-put
function Invoke-JiraUpdateWorklog {
    [CmdletBinding(DefaultParameterSetName="TimeSpent")]
    param (
        # The issue Id or Key
        [Parameter(Mandatory,Position=0)]
        [string]
        $IssueIdOrKey,

        # The worklog Id or Key
        [Parameter(Mandatory,Position=1)]
        [string]
        $WorklogId,

        # Time spent, using Jira's time notation format (e.g. 2h30m)
        [Parameter(Mandatory,ParameterSetName="TimeSpent",Position=2)]
        [string]
        $TimeSpent,

        # Time spent in seconds, represented as an integer
        [Parameter(Mandatory,ParameterSetName="TimeSpentSeconds",Position=2)]
        [int64]
        $TimeSpentSeconds,

        # The comment to add to the worklog
        [Parameter(Position=3)]
        [string]
        $Comment,

        # Controls how the remaining time estimate will be affected
        [Parameter(Position=4)]
        [ValidateSet("new","leave","auto")]
        [string]
        $AdjustMethod="auto",

        # Sets the new remaining estimate
        [Parameter(Position=5)]
        [ValidateSet({ ($AdjustMethod -ne "new") -or (($null -eq $_) -and ($_.Length -gt 0)) })]
        [string]
        $NewEstimate,

        # Date/time the work was started
        [Parameter(Position=6)]
        [datetime]
        $Started,
        
        # Set the visibility of the comment.  Use New-JiraVisibility
        [Parameter(Position=7)]
        [hashtable]
        $Visibility,

        # Additional properties to add to the object under the Properties property
        [Parameter(Position=8)]
        [hashtable[]]
        $Properties,

        # Additional properties to add to the root object
        [Parameter(Position=9)]
        [hashtable]
        $AdditionalProperties,

        # Used to expand additional attributes
        [Parameter(Position=10)]
        [ValidateScript({ Compare-StringArraySubset $JiraWorklogExpand $_ })]
        [string[]]
        $Expand,

        # Set this flag to disable notifications
        [Parameter(Position=11)]
        [switch]
        $DisableNotifications,

        # The JiraConnection object to use for the request
        [Parameter(Position=12)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issue/$IssueIdOrKey/worklog/$WorklogId"
        $verb = "PUT"

        $query = @{
            adjustEstimate = $AdjustMethod
            notifyUsers = $true
        }
        if($PSBoundParameters.ContainsKey("NewEstimate")){$query.Add("newEstimate",$NewEstimate)}
        if($PSBoundParameters.ContainsKey("DisableNotifications")){$query.notifyUsers = $false}
        if($PSBoundParameters.ContainsKey("Expand")){$query.Add("expand",$Expand -join ",")}

        $body=@{}
        if($PSBoundParameters.ContainsKey("Started")){$body.Add("",(Format-JiraRestDateTime $Started))}
        if($PSBoundParameters.ContainsKey("TimeSpent")){$body.Add("timeSpent",$TimeSpent)}
        if($PSBoundParameters.ContainsKey("TimeSpentSeconds")){$body.Add("timeSpentSeconds",$TimeSpentSeconds)}
        if($PSBoundParameters.ContainsKey("Comment")){$body.Add("comment",$Comment)}
        if($PSBoundParameters.ContainsKey("Visibility")){$body.Add("visibility",$Visibility)}
        if($PSBoundParameters.ContainsKey("Properties")){$body.Add("properties",$Properties)}
        if($PSBoundParameters.ContainsKey("AdditionalProperties")){$body += $AdditionalProperties}
        
        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Body $body -Query $query
    }
}