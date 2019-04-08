$JiraIssueCreateMetaExpand = @("projects.issuetypes.fields")

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-createmeta-get
function Invoke-JiraGetIssueCreateMetadata {
    [CmdletBinding()]
    param (
        # IDs of projects to return metadata for
        [Parameter(Position=0)]
        [int32[]]
        $ProjectIds,

        # Keys of projcts to return metadata for
        [Parameter(Position=1)]
        [string[]]
        $ProjectKeys,

        # IDs of issue types to return metadata for
        [Parameter(Position=2)]
        [int32[]]
        $IssueTypeIds,

        # Names of issue types to return metadata for
        [Parameter(Position=3)]
        [string[]]
        $IssueTypeNames,

        # Used to expand additional attributes
        [Parameter(Position=4)]
        [ValidateScript({ Compare-StringArraySubset $JiraIssueCreateMetaExpand $_ })]
        [string[]]
        $Expand,

        # The JiraConnection object to use for the request
        [Parameter(Position=5)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issue/createmeta"
        $verb = "GET"
        
        $query = @{}
        if($PSBoundParameters.ContainsKey("ProjectIds")){$query.Add("projectIds",$ProjectIds -join ",")}
        if($PSBoundParameters.ContainsKey("ProjectKeys")){$query.Add("projectKeys",$ProjectKeys -join ",")}
        if($PSBoundParameters.ContainsKey("IssueTypeIds")){$query.Add("issuetypeIds",$IssueTypeIds -join ",")}
        if($PSBoundParameters.ContainsKey("IssueTypeNames")){$query.Add("issuetypeNames",$IssueTypeNames  -join ",")}
        if($PSBoundParameters.ContainsKey("Expand")){$query.Add("expand",$Expand -join ",")}

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Query $query
    }
}