#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-project-projectIdOrKey-properties-propertyKey-get
function Invoke-JiraGetProjectProperty {
    [CmdletBinding()]
    param (
        # The project Id or Key
        [Parameter(Mandatory,Position=0)]
        [string]
        $ProjectIdOrKey,

        # The key of the property to set
        [Parameter(Mandatory,Position=1)]
        [string]
        $PropertyKey,

        # The JiraConnection object to use for the request
        [Parameter(Position=2)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/project/$ProjectIdOrKey/properties/$PropertyKey"
        $verb = "GET"

        Invoke-JiraRestRequest $JiraConnection $functionPath $verb
    }
}