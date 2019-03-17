#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-project-projectIdOrKey-versions-get
function Invoke-JiraGetProjectVersions($JiraConnection,$ProjectKey) {
    $functionPath = "/rest/api/2/project/$ProjectKey/versions"

    if($JiraConnection) {
        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionAddress $functionPath -HttpMethod GET
    } else {
        Invoke-JiraRestRequest -FunctionAddress $functionPath -HttpMethod GET
    }
}

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-project-projectIdOrKey-get
function Invoke-JiraGetProject($JiraConnection,$ProjectId,$ProjectKey) {
    $param = if ($ProjectId) { $ProjectId } else { $ProjectKey }
    $functionPath = "/rest/api/2/project/$param"
    if($JiraConnection) {
        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionAddress $functionPath -HttpMethod GET
    } else {
        Invoke-JiraRestRequest -FunctionAddress $functionPath -HttpMethod GET
    }
    
}

Export-ModuleMember -Function * -Variable *