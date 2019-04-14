function New-JiraFilterSharePermission {
    [CmdletBinding()]
    param (
        # The share type of the 
        [Parameter(Mandatory,Position=0)]
        [ValidateSet("group", "project", "projectRole", "global", "authenticated")]
        [string]
        $ShareType,

        # The ID of the project to share with, when the share type is "project" or "projectRole"
        [Parameter()]
        [int64]
        $ProjectId,

        # The ID of the project role to share with, when the share type is "projectRole"
        [Parameter()]
        [int64]
        $ProjectRoleId,

        # The group that the filter is shared with, when the share type is "group"
        [Parameter()]
        [string]
        $GroupName
    )
    process {
        #validation
        if (($ShareType -eq "group") -and (($null -eq $GroupName) -or ($GroupName -eq ""))) {
            throw "Invalid Parameter Combination: You must specify -GroupName if -ShareType = 'group'"
        }
        if (($ShareType -eq "project") -and ($null -eq $ProjectId)) {
            throw "Invalid Parameter Combination: You must specify -ProjectId if -ShareType = 'project'"
        }
        if (($ShareType -eq "projectRole") -and (($null -eq $ProjectId) -or ($null -eq $ProjectRoleId))) {
            throw "Invalid Parameter Combination: You must specify -ProjectId and -ProjectRoleId if -ShareType = 'projectRole'"
        }

        #create
        $share = @{
            type = $ShareType
        }
        if ($ShareType -eq "group") {$share.Add("group",@{name=$GroupName})}
        if ($ShareType -match "project") {$share.Add("project",@{id=$ProjectId})}
        if ($ShareType -eq "projectRole") {$share.Add("role",@{id=$ProjectRoleId})}

        #return
        $share
    }
}
<#
Details of a share permission for the filter.

REQUIRED
type 
string

The type of share permission:

* group - Shared with a group. If set in a request, then specify sharePermission.group as well.
* project - Shared with a project. If set in a request, then specify sharePermission.project as well.
* projectRole - Share with a project role in a project. This value is not returned in responses. It is used in requests, where it needs to be specify with projectId and projectRoleId.
* global - Shared globally. If set in a request, no other sharePermission properties need to be specified.
* loggedin - Shared with all logged-in users. Note: This value is set in a request by specifying authenticated as the type.
* project-unknown - Shared with a project that the user does not have access to. Cannot be set in a request.
Valid values: group, project, projectRole, global, loggedin, authenticated, project-unknown

project
Project

The project that the filter is shared with. This is similar to the project object returned by Get project but it contains a subset of the properties, which are: self, id, key, assigneeType, name, roles, avatarUrls, projectType, simplified.
For a request, specify the id for the project.

role
ProjectRole

The project role that the filter is shared with.
For a request, specify the id for the role. You must also specify the project object and id for the project that the role is in.

group
GroupName

The group that the filter is shared with. For a request, specify the name property for the group.
#>