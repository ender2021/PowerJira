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

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/project/$ProjectIdOrKey/type/$ProjectType"
        $verb = "PUT"

        $method = New-Object RestMethod @($functionPath,$verb)
        $method.Invoke($JiraContext)
    }
}