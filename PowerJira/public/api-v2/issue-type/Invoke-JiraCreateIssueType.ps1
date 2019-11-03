#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issuetype-post
function Invoke-JiraCreateIssueType {
    [CmdletBinding()]
    param (
        # The updated name of the issue type
        [Parameter(Mandatory,Position=0)]
        [string]
        $Name,

        # The updated description of the issue type
        [Parameter(Position=1)]
        [string]
        $Description,

        # Set this flag to create the issue type as a sub-task type
        [Parameter()]
        [switch]
        $Subtask,

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/issuetype/$IssueTypeId"
        $verb = "POST"

        $body = New-Object RestMethodJsonBody @{
            name = $Name
        }
        if($PSBoundParameters.ContainsKey("Description")){$body.Add("description",$Description)}
        if($PSBoundParameters.ContainsKey("Subtask")){$body.Add("type","subtask")}

        $method = New-Object BodyRestMethod @($functionPath,$verb,$body)
        $method.Invoke($JiraContext)
    }
}