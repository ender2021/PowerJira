function Invoke-JiraCreateVersion() {
    $uri = "/rest/api/3/version"
    $verb = "POST"
}

function Invoke-JiraGetProjectVersions($JiraConnection,$ProjectKey) {
    $functionPath = "/rest/api/2/project/$ProjectKey/versions"
    Invoke-JiraRestRequest -FunctionAddress $functionPath -HttpMethod GET
}

Export-ModuleMember -Function * -Variable *