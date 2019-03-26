#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-groups-picker-get
function Invoke-JiraFindGroups {
    [CmdletBinding()]
    param (
        # The search string to compare to group names
        [Parameter(Mandatory,Position=0)]
        [string]
        $SearchTerm,

        # A list of groups to exclude from th results
        [Parameter(Position=1)]
        [string[]]
        $Exclude,

        # The maximum number of results to return (also governed by an internal jira setting)
        [Parameter(Position=2)]
        [int32]
        $MaxResults,

        # The JiraConnection object to use for the request
        [Parameter(Position=3)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/groups/picker"

        $body="query=$SearchTerm"
        if($Exclude.Count -gt 0) { $Exclude | ForEach-Object {$body+="&exclude=$_"}}
        if($PSBoundParameters.ContainsKey("MaxResults")){$body+="&maxResults=$MaxResults"}

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "GET" -LiteralBody $body
    }
}

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-groupuserpicker-get
function Invoke-JiraFindUsersAndGroups {
    [CmdletBinding(DefaultParameterSetName="Simple")]
    param (
        # The search string to compare to group names
        [Parameter(Mandatory,Position=0,ParameterSetName="Simple")]
        [Parameter(Mandatory,Position=0,ParameterSetName="Field")]
        [string]
        $SearchTerm,

        # The maximum number of results to return (also governed by an internal jira setting)
        [Parameter(Position=1)]
        [int32]
        $MaxResults,

        # Custom field ID of the field to use to limit results
        [Parameter(Mandatory,ParameterSetName="Field")]
        [int32]
        $CustomFieldId,

        # The IDs of projects that returned members must have browse permissions to
        [Parameter(ParameterSetName="Field")]
        [int32[]]
        $Projects,

        # The IDs of issue types that returned members must have browse permissions to
        [Parameter(ParameterSetName="Field")]
        [int32[]]
        $IssueTypes,

        # Set this flag to return user avatars
        [switch]
        $ShowAvatar,

        # Set this value when returning user avatars
        [ValidateSet('xsmall', 'xsmall@2x', 'xsmall@3x', 'small',
                     'small@2x', 'small@3x', 'medium', 'medium@2x',
                     'medium@3x', 'large', 'large@2x', 'large@3x',
                     'xlarge', 'xlarge@2x', 'xlarge@3x', 'xxlarge',
                     'xxlarge@2x', 'xxlarge@3x', 'xxxlarge', 'xxxlarge@2x',
                     'xxxlarge@3x')]
        [string]
        $AvatarSize='xsmall',

        # Set this flag to make group searching case sensitive
        [Parameter()]
        [switch]
        $CaseSensitiveGroups,

        # Set this flag to make exclude connect add-on users and groups from results
        [Parameter()]
        [switch]
        $ExcludeConnectAddons,

        # The JiraConnection object to use for the request
        [Parameter(Position=2)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/groupuserpicker"

        $body="query=$SearchTerm"
        if($PSBoundParameters.ContainsKey("CustomFieldId")){
            $body+="&fieldId=$CustomFieldId"
            if($PSBoundParameters.ContainsKey("Projects")){$Projects | ForEach-Object {$body+="&projectId=$_"}}
            if($PSBoundParameters.ContainsKey("IssueTypes")){$IssueTypes | ForEach-Object {$body+="&issueTypeId=$_"}}            
        }
        if($PSBoundParameters.ContainsKey("MaxResults")){$body+="&maxResults=$MaxResults"}
        if(!$PSBoundParameters.ContainsKey("CaseSensitiveGroups")){$body+="&caseInsensitive=true"}
        if($PSBoundParameters.ContainsKey("ShowAvatar")){
            $body+="&showAvatar=true&avatarSize=$AvatarSize"
        }
        if($PSBoundParameters.ContainsKey("ExcludeConnectAddons")){$body+="excludeConnectAddons=true"}

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "GET" -LiteralBody $body
    }
}

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-group-post
function Invoke-JiraCreateGroup {
    [CmdletBinding()]
    param (
        # Name of the group to create
        [Parameter(Mandatory,Position=0)]
        [string]
        $Name,

        # The JiraConnection object to use for the request
        [Parameter(Position=1)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/group"

        $body=@{
            name = $Name
        }

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "POST" -Body $body
    }
}

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-group-delete
function Invoke-JiraDeleteGroup {
    [CmdletBinding()]
    param (
        # Name of the group to create
        [Parameter(Mandatory,Position=0)]
        [string]
        $Name,

        # The name of a group to replace the deleted group in comment/worklog restrictions
        [Parameter(Position=1)]
        [string]
        $SwapGroup,

        # The JiraConnection object to use for the request
        [Parameter(Position=2)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/group"

        $body=@{
            groupname = $Name
        }
        if($PSBoundParameters.ContainsKey("SwapGroup")){$body.Add("swapGroup",$SwapGroup)}

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "DELETE" -Body $body
    }
}

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-group-user-post
function Invoke-JiraAddUserToGroup {
    [CmdletBinding()]
    param (
        # Name of the group to add the user to
        [Parameter(Mandatory,Position=0)]
        [string]
        $Name,

        # The accountID of the user to add
        [Parameter(Mandatory,Position=1)]
        [string]
        $User,

        # The JiraConnection object to use for the request
        [Parameter(Position=2)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/group/user" + '?' + "groupname=$Name"

        $body=@{
            accountId = $User
        }

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "POST" -Body $body
    }
}

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-group-post
function Invoke-JiraGetGroupUsers {
    [CmdletBinding()]
    param (
        # Name of the group for which to get users
        [Parameter(Mandatory,Position=0)]
        [string]
        $Name,

        # The index of the first item to return.  The default is 0.
        [Parameter(Position=1)]
        [int64]
        $StartAt=0,

        # The maximum number of results to return.  This is hard-limited to 50.
        [Parameter(Position=2)]
        [ValidateRange(1,50)]
        [int32]
        $MaxResults=50,

        # Set this flag to include inactive users in the results
        [Parameter(Position=3)]
        [switch]
        $IncludeInactive,

        # The JiraConnection object to use for the request
        [Parameter(Position=4)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/group/member"

        $body=@{
            groupname = $Name
            maxResults = $MaxResults
            startAt = $StartAt
        }
        if($PSBoundParameters.ContainsKey("IncludeInactive")){$body.Add("includeInactiveUsers",$true)}

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "GET" -Body $body
    }
}

Export-ModuleMember -Function * -Variable *