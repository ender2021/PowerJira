#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-worklog-id-delete
function Invoke-JiraDeleteWorklog {
    [CmdletBinding()]
    param (
        # The issue Id or Key
        [Parameter(Mandatory,Position=0)]
        [string]
        $IssueIdOrKey,

        # The worklog Id or Key
        [Parameter(Mandatory,Position=1)]
        [string]
        $WorklogId,

        # Controls how the remaining time estimate will be affected
        [Parameter(Position=2)]
        [ValidateSet("new","leave","auto","manual")]
        [string]
        $AdjustMethod="auto",

        # Sets the new remaining estimate
        [Parameter(Position=3)]
        [ValidateSet({ ($AdjustMethod -ne "new") -or (($null -eq $_) -and ($_.Length -gt 0)) })]
        [string]
        $NewEstimate,

        # The amount to increase the issue estimate by, if $AdjustMethod is set to manual
        [Parameter(Position=4)]
        [ValidateSet({ ($AdjustMethod -ne "manual") -or (($null -eq $_) -and ($_.Length -gt 0)) })]
        [string]
        $IncreaseBy,

        # Set this flag to disable notifications
        [Parameter(Position=5)]
        [switch]
        $DisableNotifications,

        # The JiraContext object to use for the request
        [Parameter()]
        [object]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/issue/$IssueIdOrKey/worklog/$WorklogId"
        $verb = "DELETE"

        $query = New-PACRestMethodQueryParams @{
            adjustEstimate = $AdjustMethod
            notifyUsers = $true
        }
        if($PSBoundParameters.ContainsKey("NewEstimate")){$query.Add("newEstimate",$NewEstimate)}
        if($PSBoundParameters.ContainsKey("IncreaseBy")){$query.Add("increaseBy",$IncreaseBy)}
        if($PSBoundParameters.ContainsKey("DisableNotifications")){$query.notifyUsers = $false}
        
        $method = New-PACRestMethod $functionPath $verb $query
        $method.Invoke($JiraContext)
    }
}