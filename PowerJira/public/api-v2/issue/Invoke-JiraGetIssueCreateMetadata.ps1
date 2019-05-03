$JiraIssueCreateMetaExpand = @("projects.issuetypes.fields")

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-createmeta-get
function Invoke-JiraGetIssueCreateMetadata {
    [CmdletBinding()]
    param (
        # IDs of projects to return metadata for
        [Parameter(Position=0,ValueFromPipeline,ValueFromPipelineByPropertyName)]
        [Alias("ProjectId")]
        [int32]
        $Id,

        # Keys of projcts to return metadata for
        [Parameter(Position=1,ValueFromPipeline,ValueFromPipelineByPropertyName)]
        [Alias("ProjectKey")]
        [string]
        $Key,

        # IDs of issue types to return metadata for
        [Parameter(Position=2,ValueFromPipelineByPropertyName)]
        [Alias("IssueTypeIds")]
        [int32[]]
        $TypeIds,

        # Names of issue types to return metadata for
        [Parameter(Position=3,ValueFromPipelineByPropertyName)]
        [Alias("IssueTypeNames")]
        [string[]]
        $TypeNames,

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
    begin {
        $ProjectIds = @()
        $ProjectKeys = @()
        $AllTypeIds = @()
        $AllTypeNames = @()
    }
    process {
        if($PSBoundParameters.ContainsKey("Id")){$ProjectIds += $Id}
        if($PSBoundParameters.ContainsKey("Key")){$ProjectKeys += $Key}
        if($PSBoundParameters.ContainsKey("TypeIds")){$AllTypeIds += $TypeIds}
        if($PSBoundParameters.ContainsKey("TypeNames")){$AllTypeNames += $TypeNames}
    }
    end {
        $functionPath = "/rest/api/2/issue/createmeta"
        $verb = "GET"
        
        $query = @{}
        if($ProjectIds.Length -gt 0){$query.Add("projectIds",$ProjectIds -join ",")}
        if($ProjectKeys.Length -gt 0){$query.Add("projectKeys",$ProjectKeys -join ",")}
        if($AllTypeIds.Length -gt 0){$query.Add("issuetypeIds",$AllTypeIds -join ",")}
        if($AllTypeNames.Length -gt 0){$query.Add("issuetypeNames",$AllTypeNames  -join ",")}
        if($PSBoundParameters.ContainsKey("Expand")){$query.Add("expand",$Expand -join ",")}

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Query $query
    }
}