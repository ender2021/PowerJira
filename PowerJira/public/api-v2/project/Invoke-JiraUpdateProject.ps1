$JiraProjectExpand = @("description","issueTypes","lead","projectKeys")

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-project-projectIdOrKey-put
function Invoke-JiraUpdateProject {
    [CmdletBinding()]
    param (
        # The project ID or key
        [Parameter(Mandatory,Position=0)]
        [string]
        $ProjectIdOrKey,

        # The updated key for the project
        [Parameter(Position=1)]
        [string]
        $Key,

        # The name for the project
        [Parameter(Position=2)]
        [string]
        $Name,

        # The account ID of the project lead
        [Parameter(Position=3)]
        [string]
        $ProjectLead,

        # A description for the project
        [Parameter(Position=4)]
        [string]
        $Description,

        # A URL for the project website
        [Parameter(Position=5)]
        [string]
        $Url,

        # The ID of the avatar to set for the project
        [Parameter(Position=6)]
        [int64]
        $AvatarId,

        # The ID of the Issue Security Scheme to set for the project
        [Parameter(Position=7)]
        [int64]
        $IssueSecurityScheme,

        # The ID of the Permission Scheme to set for the project
        [Parameter(Position=8)]
        [int64]
        $PermissionScheme,

        # The ID of the Notification Scheme to set for the project
        [Parameter(Position=9)]
        [int64]
        $NotificationScheme,

        # The ID of the category to set for the project
        [Parameter(Position=10)]
        [int64]
        $CategoryId,

        # Default assignee behavior when an issue is created in the project
        [Parameter(Position=11)]
        [ValidateSet("PROJECT_LEAD","UNASSIGNED")]
        [string]
        $DefaultAssignee,
        
        # Used to expand additional attributes
        [Parameter(Position=12)]
        [ValidateScript({ Compare-StringArraySubset $JiraProjectExpand $_ })]
        [string[]]
        $Expand,

        # The JiraConnection object to use for the request
        [Parameter(Position=13)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/project/$ProjectIdOrKey"
        $verb = "PUT"

        $query = @{}
        if($PSBoundParameters.ContainsKey("Expand")){$query.Add("expand",$Expand -join ",")}

        $body=@{}
        if($PSBoundParameters.ContainsKey("Key")){$body.Add("key",$Key)}
        if($PSBoundParameters.ContainsKey("Name")){$body.Add("name",$Name)}
        if($PSBoundParameters.ContainsKey("ProjectLead")){$body.Add("leadAccountId",$ProjectLead)}
        if($PSBoundParameters.ContainsKey("Description")){$body.Add("description",$Description)}
        if($PSBoundParameters.ContainsKey("Url")){$body.Add("url",$Url)}
        if($PSBoundParameters.ContainsKey("AvatarId")){$body.Add("avatarId",$AvatarId)}
        if($PSBoundParameters.ContainsKey("IssueSecurityScheme")){$body.Add("issueSecurityScheme",$IssueSecurityScheme)}
        if($PSBoundParameters.ContainsKey("PermissionScheme")){$body.Add("permissionScheme",$PermissionScheme)}
        if($PSBoundParameters.ContainsKey("NotificationScheme")){$body.Add("notificationScheme",$NotificationScheme)}
        if($PSBoundParameters.ContainsKey("CategoryId")){$body.Add("categoryId",$CategoryId)}
        if($PSBoundParameters.ContainsKey("DefaultAssignee")){$body.Add("assigneeType",$DefaultAssignee)}

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Query $query -Body $body
    }
}