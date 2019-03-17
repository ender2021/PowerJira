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
        if ($Description) {$body.Add("description",$Description)}
        if ($StartDate) {$body.Add("startDate",(Format-JiraRestDateTime $StartDate))}
        if ($ReleaseDate) {$body.Add("releaseDate",(Format-JiraRestDateTime $ReleaseDate))}

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "POST" -Body $body
    }
}

function Invoke-JiraUpdateVersion($JiraConnection,$VersionId,$Name,$Description,$StartDate,$ReleaseDate,$Archived,$Released,$UnfixedIssuesTargetVersion) {
    $functionPath = "/rest/api/2/version/$VersionId"
    
    $body = @{
        id = $VersionId
    }
    if ($Description) {$body.Add("description",$Description)}
    if ($StartDate) {$body.Add("startDate",$StartDate)}
    if ($ReleaseDate) {$body.Add("releaseDate",$ReleaseDate)}
    if ($Archived) {$body.Add("archived",$Archived)}
    if ($Released) {$body.Add("released",$Released)}
    if ($UnfixedIssuesTargetVersion) {$body.Add("moveUnfixedIssuesTo",$UnfixedIssuesTargetVersion)}

    Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod PUT -Body $body
}

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-version-id-removeAndSwap-post
function Invoke-JiraDeleteVersion($JiraConnection,$VersionId,$FixTargetVersion,$AffectedTargetVersion) {
    $functionPath = "/rest/api/2/version/$VersionId/removeAndSwap"
    
    $body = @{}
    if ($FixTargetVersion) {$body.Add("moveFixIssuesTo",$FixTargetVersion)}
    if ($AffectedTargetVersion) {$body.Add("moveAffectedIssuesTo",$AffectedTargetVersion)}
    
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
    if ($After) {$body.Add("after",$After)} else {$body.Add("position",$Position)}

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