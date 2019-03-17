# https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-version-post
function Invoke-JiraCreateVersion($JiraConnection,$ProjectId,$Name,$Description,$StartDate,$ReleaseDate,$Archived) {
    $functionPath = "/rest/api/2/version"
    
    $body = @{
        name = $Name
        projectId = $ProjectId
    }
    if ($Description) {$body.Add("description",$Description)}
    if ($StartDate) {$body.Add("startDate",$StartDate)}
    if ($ReleaseDate) {$body.Add("releaseDate",$ReleaseDate)}
    if ($Archived) {$body.Add("archived",$Archived)}

    if($JiraConnection) {
        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionAddress $functionPath -HttpMethod POST -Body $body
    } else {
        Invoke-JiraRestRequest -FunctionAddress $functionPath -HttpMethod POST -Body $body
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

    if($JiraConnection) {
        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionAddress $functionPath -HttpMethod PUT -Body $body
    } else {
        Invoke-JiraRestRequest -FunctionAddress $functionPath -HttpMethod PUT -Body $body
    }
}

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-version-id-removeAndSwap-post
function Invoke-JiraDeleteVersion($JiraConnection,$VersionId,$FixTargetVersion,$AffectedTargetVersion) {
    $functionPath = "/rest/api/2/version/$VersionId/removeAndSwap"
    
    $body = @{}
    if ($FixTargetVersion) {$body.Add("moveFixIssuesTo",$FixTargetVersion)}
    if ($AffectedTargetVersion) {$body.Add("moveAffectedIssuesTo",$AffectedTargetVersion)}
    
    if($JiraConnection) {
        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionAddress $functionPath -HttpMethod POST -Body $body
    } else {
        Invoke-JiraRestRequest -FunctionAddress $functionPath -HttpMethod POST -Body $body
    }
}

Export-ModuleMember -Function * -Variable *