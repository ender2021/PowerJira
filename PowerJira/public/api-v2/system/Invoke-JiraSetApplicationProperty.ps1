#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-application-properties-id-put
function Invoke-JiraSetApplicationProperty {
    [CmdletBinding()]
    param (
        # ID of the property to set
        [Parameter(Mandatory,Position=0)]
        [string]
        $PropertyId,

        # The new value for the property
        [Parameter(Mandatory,Position=1)]
        [string]
        $Value,

        # The JiraConnection object to use for the request
        [Parameter(Position=2)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/application-properties/$PropertyId"
        $verb = "PUT"

        $body=@{
            id = $PropertyId
            value = $Value
        }

        Invoke-JiraRestRequest $JiraConnection $functionPath $verb -Body $body
    }
}