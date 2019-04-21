#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-projectCategory-post
function Invoke-JiraCreateProjectCategory {
    [CmdletBinding()]
    param (
        # A name for the category
        [Parameter(Mandatory,Position=0)]
        [string]
        $Name,

        # A description for the category
        [Parameter(Mandatory,Position=1)]
        [string]
        $Description,

        # The JiraConnection object to use for the request
        [Parameter(Position=2)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/projectCategory"
        $verb = "POST"

        $body=@{
            name = $Name
            description = $Description
        }

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Body $body
    }
}