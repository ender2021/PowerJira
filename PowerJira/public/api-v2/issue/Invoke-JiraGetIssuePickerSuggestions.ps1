#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-picker-get
function Invoke-JiraGetIssuePickerSuggestions {
    [CmdletBinding()]
    param (
        # A string to match against text fields in the issue such as title, description, or comments.
        [Parameter(Position=0)]
        [string]
        $TextFilter,

        # A JQL string defining the set of issues from which to make suggestions
        [Parameter(Position=1)]
        [string]
        $JqlFilter,

        # The ID of a project to which an issue must belong in order to be included in the suggestions
        [Parameter(Position=2)]
        [string]
        $ProjectFilter,

        # Provide a single issue key to be excluded from results.  Useful if using this in the context of an issue.
        [Parameter(Position=3)]
        [string]
        $ExcludeIssueKey,

        # Set this flag to exclude the parent issue from results if ExcludeIssueKey is a subtask
        [Parameter()]
        [switch]
        $HideSubTaskParent,        

        # Set this flag to exclude subtasks from the suggestion list
        [Parameter()]
        [switch]
        $HideSubTasks,        

        # The JiraConnection object to use for the request
        [Parameter(Position=4)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issue/picker"
        $verb = "GET"

        $query=@{
            showSubTasks = $true
            showSubTaskParent = $true
        }
        if($PSBoundParameters.ContainsKey("TextFilter")){$query.Add("query",$TextFilter)}
        if($PSBoundParameters.ContainsKey("JqlFilter")){$query.Add("currentJQL",$JqlFilter)}
        if($PSBoundParameters.ContainsKey("ProjectFilter")){$query.Add("currentProjectId",$ProjectFilter)}
        if($PSBoundParameters.ContainsKey("ExcludeIssueKey")){$query.Add("currentIssueKey",$ExcludeIssueKey)}
        if($PSBoundParameters.ContainsKey("HideSubTaskParent")){$query.showSubTaskParent = $false}
        if($PSBoundParameters.ContainsKey("HideSubTasks")){$query.showSubTasks = $false}

      Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Query $query
    }
}