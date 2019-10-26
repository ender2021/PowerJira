#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-avatar-type-system-get
function Invoke-JiraGetSystemAvatars {
    [CmdletBinding()]
    param (
        # The type of avatars to get
        [Parameter(Mandatory,Position=0,ValueFromPipeline,ValueFromPipelineByPropertyName)]
        [ValidateSet("issuetype","project","user")]
        [string]
        $Type,

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    begin {
        $results = @()
    }
    process {
        $functionPath = "/rest/api/2/avatar/$Type/system"
        $verb = "GET"

        $method = [RestMethod]::new($functionPath,$verb)
        $results += $method.Invoke($JiraContext).system
    }
    end {
        $results
    }
}