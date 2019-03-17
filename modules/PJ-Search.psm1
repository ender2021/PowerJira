#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-search-get
function Invoke-JiraSearchIssues($JiraConnection,$JQL,$StartAt=0,$MaxResults=50,$Fields=@("*navigable"),$Validate="strict") {
    $functionPath = "/rest/api/2/search"

    $body = @{
        jql = $JQL
        startAt = $StartAt
        maxResults = $MaxResults
        fields = $Fields
        validateQuery = $Validate
    }
    
    Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "POST" -Body $body
}

Export-ModuleMember -Function * -Variable *