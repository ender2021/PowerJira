# https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-version-post
function Invoke-JiraCreateVersion {
    [CmdletBinding()]
    param (
        # The ID of the project where the version will be created
        [Parameter(Mandatory=$true)]
        [int32]
        $ProjectId,

        # The name of the version to create.  Must be unique within the project.
        [Parameter(Mandatory=$true)]
        [ValidateLength(1,255)]
        [string]
        $Name,

        # A short description of the version
        [Parameter(Mandatory=$false)]
        [string]
        $Description,

        # The start date of the version. Will be converted to ISO 8601 format (yyyy-mm-dd). 
        [Parameter(Mandatory=$false)]
        [datetime]
        $StartDate,

        # The release date of the version. Will be converted to ISO 8601 format (yyyy-mm-dd). 
        [Parameter(Mandatory=$false)]
        [datetime]
        $ReleaseDate,

        # The JiraConnection object to use for the request
        [Parameter(Mandatory=$false)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/version"
    
        $body = @{
            projectId = $ProjectId
            name = $Name
        }
        if($PSBoundParameters.ContainsKey("Description")){$body.Add("description",$Description)}
        if($PSBoundParameters.ContainsKey("StartDate")){$body.Add("startDate",(Format-JiraRestDateTime $StartDate))}
        if($PSBoundParameters.ContainsKey("ReleaseDate")){$body.Add("releaseDate",(Format-JiraRestDateTime $ReleaseDate))}

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "POST" -Body $body
    }
}

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-version-id-put
function Invoke-JiraUpdateVersion {
    [CmdletBinding()]
    param (
        # The ID of the version to update
        [Parameter(Mandatory=$true)]
        [int32]
        $VersionId,

        # The updated name of the version.  Must be unique within the project.
        [Parameter(Mandatory=$false)]
        [ValidateLength(1,255)]
        [string]
        $Name,

        # A short description of the version
        [Parameter(Mandatory=$false)]
        [string]
        $Description,

        # The start date of the version. Will be converted to ISO 8601 format (yyyy-mm-dd). 
        [Parameter(Mandatory=$false)]
        [datetime]
        $StartDate,

        # The release date of the version. Will be converted to ISO 8601 format (yyyy-mm-dd). 
        [Parameter(Mandatory=$false)]
        [datetime]
        $ReleaseDate,

        # Indicates that the version is archived
        [Parameter(Mandatory=$false)]
        [bool]
        $Archived,

        # Indicates that the version is released
        [Parameter(Mandatory=$false)]
        [bool]
        $Released,

        # The ID of the version to move unfixed issues into
        [Parameter(Mandatory=$false)]
        [int32]
        $UnfixedIssuesVersionId,

        # The JiraConnection object to use for the request
        [Parameter(Mandatory=$false)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/version/$VersionId"
        
        $body = @{
            id = $VersionId
        }
        if($PSBoundParameters.ContainsKey("Description")){$body.Add("description",$Description)}
        if($PSBoundParameters.ContainsKey("StartDate")){$body.Add("startDate",(Format-JiraRestDateTime $StartDate))}
        if($PSBoundParameters.ContainsKey("ReleaseDate")){$body.Add("releaseDate",(Format-JiraRestDateTime $ReleaseDate))}
        if($PSBoundParameters.ContainsKey("Archived")){$body.Add("archived",$Archived)}
        if($PSBoundParameters.ContainsKey("Released")){$body.Add("released",$Released)}
        if($PSBoundParameters.ContainsKey("UnfixedIssuesVersionId")) {$body.Add("moveUnfixedIssuesTo",$UnfixedIssuesVersionId)}

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "PUT" -Body $body
    }
}

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-version-id-removeAndSwap-post
function Invoke-JiraDeleteVersion($JiraConnection,$VersionId,$FixTargetVersion,$AffectedTargetVersion) {
    $functionPath = "/rest/api/2/version/$VersionId/removeAndSwap"
    
    $body = @{}
    if($PSBoundParameters.ContainsKey("FixTargetVersion")){$body.Add("moveFixIssuesTo",$FixTargetVersion)}
    if($PSBoundParameters.ContainsKey("AffectedTargetVersion")){$body.Add("moveAffectedIssuesTo",$AffectedTargetVersion)}
    
    Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "POST" -Body $body
}

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-version-id-GET
function Invoke-JiraGetVersion($JiraConnection,$VersionId) {
    $functionPath = "/rest/api/2/version/$VersionId"
    
    Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "GET"
}

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-version-id-move-post
function Invoke-JiraMoveVersion($JiraConnection,$VersionId,$After,$Position) {
    $functionPath = "/rest/api/2/version/$VersionId/move"
    
    $body = @{}
    if($PSBoundParameters.ContainsKey("After")){$body.Add("after",$After)} else {$body.Add("position",$Position)}

    Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "POST" -Body $body
}

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-version-id-mergeto-moveIssuesTo-put
function Invoke-JiraMergeVersion($JiraConnection,$SourceVersionId,$TargetVersionId) {
    $functionPath = "/rest/api/2/version/$SourceVersionId/mergeto/$TargetVersionId"
    
    Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "PUT"
}

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-version-id-relatedIssueCounts-get
function Invoke-JiraGetVersionRelatedIssueCounts($JiraConnection,$VersionId) {
    $functionPath = "/rest/api/2/version/$VersionId/relatedIssueCounts"
    
    Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "GET"
}

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-version-id-unresolvedIssueCount-get
function Invoke-JiraGetVersionUnresolvedIssueCount($JiraConnection,$VersionId) {
    $functionPath = "/rest/api/2/version/$VersionId/unresolvedIssueCount"
    
    Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "GET"
}

Export-ModuleMember -Function * -Variable *