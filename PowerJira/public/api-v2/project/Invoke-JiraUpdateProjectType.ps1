#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-project-projectIdOrKey-type-newProjectTypeKey-put
function Invoke-JiraUpdateProjectType {
    [CmdletBinding()]
    param (
        # The ID or key of the project to update
        [Parameter(Mandatory,Position=0)]
        [string]
        $ProjectIdOrKey,

        # The new project type for the project
        [Parameter(Mandatory,Position=1)]
        [ValidateSet("ops", "software", "service_desk", "business")]
        [string]
        $ProjectType,

        # The JiraConnection object to use for the request
        [Parameter(Position=2)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/project/$ProjectIdOrKey/type/$ProjectType"
        $verb = "PUT"

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb
    }
}