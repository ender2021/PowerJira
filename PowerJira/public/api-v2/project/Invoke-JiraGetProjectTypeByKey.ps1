#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-project-type-projectTypeKey-get
function Invoke-JiraGetProjectTypeByKey {
    [CmdletBinding()]
    param (
        # Get project type with this key. Valid values are ops, software, service_desk, business
        [Parameter(Mandatory,Position=0)]
        [ValidateSet("ops","software","service_desk","business")]
        $Key,

        # The JiraConnection object to use for the request
        [Parameter()]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/project/type/$Key"

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "GET"
    }
}