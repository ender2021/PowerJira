function New-JiraIssueTypeWorkflowMapping {
    [CmdletBinding()]
    param (
        # Issue Type ID
        [Parameter(Mandatory,Position=0)]
        [int64]
        $IssueTypeId,

        # Workflow name
        [Parameter(Mandatory,Position=1)]
        [string]
        $WorkflowName
    )
    process {
        @{
            type = $IssueTypeId
            workflow = $WorkflowName
        }
    }
}