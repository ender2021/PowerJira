#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issuetype-id-put
function Invoke-JiraUpdateIssueType {
    [CmdletBinding()]
    param (
        # The ID of the issue type
        [Parameter(Mandatory,Position=0)]
        [string]
        $IssueTypeId,

        # The updated name of the issue type
        [Parameter(Position=1)]
        [string]
        $Name,

        # The updated description of the issue type
        [Parameter(Position=2)]
        [string]
        $Description,

        # The updated Avatar Id for the issue type
        [Parameter(Position=3)]
        [int64]
        $AvatarId,

        # The JiraContext object to use for the request
        [Parameter()]
        [object]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/issuetype/$IssueTypeId"
        $verb = "PUT"

        $body = New-PACRestMethodJsonBody
        if($PSBoundParameters.ContainsKey("Name")){$body.Add("name",$Name)}
        if($PSBoundParameters.ContainsKey("Description")){$body.Add("description",$Description)}
        if($PSBoundParameters.ContainsKey("AvatarId")){$body.Add("avatarId",$AvatarId)}

        $method = New-PACRestMethod $functionPath $verb $null $body
        $method.Invoke($JiraContext)
    }
}