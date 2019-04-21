function New-JiraExpressionContext {
    [CmdletBinding()]
    param (
        # An issue ID or key to set the 'issue' context variable
        [Parameter(Position=0)]
        [string]
        $IssueIdOrKey,

        # JQL specifying a set of issues to use for the 'issues' context variable.  Use New-JiraContextJql
        [Parameter(Position=1)]
        [hashtable]
        $ContextJql,

        # A project ID or key to set the 'project' context variable
        [Parameter(Position=2)]
        [string]
        $ProjectIdOrKey,

        # A sprint ID to set the 'sprint' context variable
        [Parameter(Position=3)]
        [int64]
        $SprintID,

        # A board ID to set the 'board' context variable
        [Parameter(Position=4)]
        [int64]
        $BoardID
    )
    process {
        $obj = @{}
        if($PSBoundParameters.ContainsKey("IssueIdOrKey")){
            $issue = @{}
            $issue.Add((IIf (Test-Id $IssueIdOrKey) "id" "key"), $IssueIdOrKey)
            $obj.Add("issue",$issue)
        }
        if($PSBoundParameters.ContainsKey("ProjectIdOrKey")){
            $project = @{}
            $project.Add((IIf (Test-Id $ProjectIdOrKey) "id" "key"), $ProjectIdOrKey)
            $obj.Add("project",$project)
        }
        if($PSBoundParameters.ContainsKey("ContextJql")){$obj.Add("issues",$ContextJql)}
        if($PSBoundParameters.ContainsKey("SprintId")){$obj.Add("sprint",$SprintId)}
        if($PSBoundParameters.ContainsKey("BoardId")){$obj.Add("board",$BoardId)}
        $obj
    }
}