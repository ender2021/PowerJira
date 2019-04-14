#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-project-post
function Invoke-JiraCreateProject {
    [CmdletBinding()]
    param (
        # The key for the project
        [Parameter(Mandatory,Position=0)]
        [string]
        $Key,

        # The name for the project
        [Parameter(Mandatory,Position=1)]
        [string]
        $Name,

        # The type of the project
        [Parameter(Mandatory,Position=2)]
        [ValidateSet("ops", "software", "service_desk", "business")]
        [string]
        $Type,

        # The template to use to create the project
        [Parameter(Mandatory,Position=3)]
        [ValidateSet("com.pyxis.greenhopper.jira:gh-simplified-agility-kanban",
                     "com.pyxis.greenhopper.jira:gh-simplified-agility-scrum",
                     "com.pyxis.greenhopper.jira:gh-simplified-basic",
                     "com.pyxis.greenhopper.jira:gh-simplified-kanban-classic",
                     "com.pyxis.greenhopper.jira:gh-simplified-scrum-classic",
                     "com.atlassian.servicedesk:simplified-it-service-desk",
                     "com.atlassian.servicedesk:simplified-internal-service-desk",
                     "com.atlassian.servicedesk:simplified-external-service-desk",
                     "com.atlassian.jira-core-project-templates:jira-core-simplified-content-management",
                     "com.atlassian.jira-core-project-templates:jira-core-simplified-document-approval",
                     "com.atlassian.jira-core-project-templates:jira-core-simplified-lead-tracking",
                     "com.atlassian.jira-core-project-templates:jira-core-simplified-process-control",
                     "com.atlassian.jira-core-project-templates:jira-core-simplified-procurement",
                     "com.atlassian.jira-core-project-templates:jira-core-simplified-project-management",
                     "com.atlassian.jira-core-project-templates:jira-core-simplified-recruitment",
                     "com.atlassian.jira-core-project-templates:jira-core-simplified-task-",
                     "com.atlassian.jira.jira-incident-management-plugin:im-incident-management"
                     )]
        [string]
        $Template,

        # The account ID of the project lead
        [Parameter(Mandatory,Position=4)]
        [string]
        $ProjectLead,

        # A description for the project
        [Parameter(Position=5)]
        [string]
        $Description,

        # A URL for the project website
        [Parameter(Position=6)]
        [string]
        $Url,

        # The ID of the avatar to set for the project
        [Parameter(Position=7)]
        [int64]
        $AvatarId,

        # The ID of the Issue Security Scheme to set for the project
        [Parameter(Position=8)]
        [int64]
        $IssueSecurityScheme,

        # The ID of the Permission Scheme to set for the project
        [Parameter(Position=9)]
        [int64]
        $PermissionScheme,

        # The ID of the Notification Scheme to set for the project
        [Parameter(Position=10)]
        [int64]
        $NotificationScheme,

        # The ID of the category to set for the project
        [Parameter(Position=11)]
        [int64]
        $CategoryId,

        # Set this flag to configure the project to assign issues to the project lead by default
        [Parameter()]
        [switch]
        $AssignProjectLead,

        # The JiraConnection object to use for the request
        [Parameter(Position=12)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/project"
        $verb = "POST"

        $body=@{
            key = $Key
            name = $Name
            projectTypeKey = $Type
            projectTemplateKey = $Template
            leadAccountId = $ProjectLead
            assigneeType = if($AssignProjectLead) {"PROJECT_LEAD"} else {"UNASSIGNED"}
        }
        if($PSBoundParameters.ContainsKey("Description")){$body.Add("description",$Description)}
        if($PSBoundParameters.ContainsKey("Url")){$body.Add("url",$Url)}
        if($PSBoundParameters.ContainsKey("AvatarId")){$body.Add("avatarId",$AvatarId)}
        if($PSBoundParameters.ContainsKey("IssueSecurityScheme")){$body.Add("issueSecurityScheme",$IssueSecurityScheme)}
        if($PSBoundParameters.ContainsKey("PermissionScheme")){$body.Add("permissionScheme",$PermissionScheme)}
        if($PSBoundParameters.ContainsKey("NotificationScheme")){$body.Add("notificationScheme",$NotificationScheme)}
        if($PSBoundParameters.ContainsKey("CategoryId")){$body.Add("categoryId",$CategoryId)}

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Body $body
    }
}