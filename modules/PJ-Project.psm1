#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-project-projectIdOrKey-versions-get
function Invoke-JiraGetProjectVersions($JiraConnection=$Global:PJ_JiraSession,$ProjectKey) {
    $functionPath = "/rest/api/2/project/$ProjectKey/versions"
    Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionAddress $functionPath -HttpMethod GET
}

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-project-projectIdOrKey-get
function Invoke-JiraGetProject($JiraConnection=$Global:PJ_JiraSession,$ProjectId,$ProjectKey) {
    $param = if ($ProjectId) { $ProjectId } else { $ProjectKey }
    $functionPath = "/rest/api/2/project/$param"
    Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionAddress $functionPath -HttpMethod GET
}

Export-ModuleMember -Function * -Variable *