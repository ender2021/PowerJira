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

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/groupuserpicker"
        $verb = "GET"

        $query = New-Object RestMethodQueryParams @{
            query = $SearchTerm
        }

        if($PSBoundParameters.ContainsKey("CustomFieldId")){
            $query.Add("fieldId",$CustomFieldId)
            if($PSBoundParameters.ContainsKey("Projects")){$Projects | ForEach-Object {$query.Add("projectId",$_)}}
            if($PSBoundParameters.ContainsKey("IssueTypes")){$IssueTypes | ForEach-Object {$query.Add("issueTypeId",$_)}}
        }
        if($PSBoundParameters.ContainsKey("MaxResults")){$query.Add("maxResults",$MaxResults)}
        if(!$PSBoundParameters.ContainsKey("CaseSensitiveGroups")){$query.Add("caseInsensitive",$true)}
        if($PSBoundParameters.ContainsKey("ShowAvatar")){
            $query.Add("showAvatar",$true)
            $query.Add("avatarSize",$AvatarSize)
        }
        if($PSBoundParameters.ContainsKey("ExcludeConnectAddons")){$query.Add("excludeConnectAddons",$true)}

        $method = New-Object RestMethod @($functionPath,$verb,$query)
        $method.Invoke($JiraContext)
    }
}