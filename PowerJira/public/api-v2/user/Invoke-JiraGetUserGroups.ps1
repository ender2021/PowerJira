#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-user-groups-get
function Invoke-JiraGetUserGroups {
    [CmdletBinding()]
    param (
        # The accountID of the user to retrieve groups for
        [Parameter(Mandatory,Position=0)]
        [string]
        $AccountId,

        # The JiraConnection object to use for the request
        [Parameter(Position=1)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/user/groups"
        $verb = "GET"

        $body=@{accountId=$AccountId}

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod $verb -Body $body
    }
}