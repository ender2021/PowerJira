#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-user-groups-get
function Invoke-JiraGetUserGroups {
    [CmdletBinding()]
    param (
        # The accountID of the user to retrieve groups for
        [Parameter(Mandatory,Position=0)]
        [string]
        $AccountId,

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/user/groups"
        $verb = "GET"

        $query = New-Object RestMethodQueryParams @{accountId=$AccountId}

        $method = New-Object RestMethod @($functionPath,$verb,$query)
        $method.Invoke($JiraContext)
    }
}