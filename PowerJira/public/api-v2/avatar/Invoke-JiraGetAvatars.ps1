#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-universal-avatar-type-type-owner-entityId-get
function Invoke-JiraGetAvatars {
    [CmdletBinding()]
    param (
        # The type of avatars to get
        [Parameter(Mandatory,Position=0)]
        [ValidateSet("issuetype","project")]
        [string]
        $Type,

        # The ID of the issuetype or project to retrieve avatars for
        [Parameter(Mandatory,Position=1,ValueFromPipeline,ValueFromPipelineByPropertyName)]
        [string]
        $Id,

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    begin {
        $results = @()
    }
    process {
        $functionPath = "/rest/api/2/universal_avatar/type/$Type/owner/$Id"
        $verb = "GET"

        $method = New-Object RestMethod @($functionPath,$verb)
        $results += $method.Invoke($JiraContext)
    }
    end {
        $results
    }
}