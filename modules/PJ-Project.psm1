#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-project-projectIdOrKey-versions-get
function Invoke-JiraGetProjectVersions($JiraConnection,$ProjectKey) {
    $functionPath = "/rest/api/2/project/$ProjectKey/versions"

    Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "GET"
}

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-project-projectIdOrKey-get
function Invoke-JiraGetProject($JiraConnection,$ProjectId,$ProjectKey) {
    $param = if ($ProjectId) { $ProjectId } else { $ProjectKey }
    $functionPath = "/rest/api/2/project/$param"
    
    Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "GET"   
}

Export-ModuleMember -Function * -Variable *