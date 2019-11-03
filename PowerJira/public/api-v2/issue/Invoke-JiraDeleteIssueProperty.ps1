#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-properties-propertyKey-delete
function Invoke-JiraDeleteIssueProperty {
    [CmdletBinding(DefaultParameterSetName="Id")]
    param (
        # The ID of the issue
        [Parameter(Mandatory,Position=0,ValueFromPipelineByPropertyName,ParameterSetName="Id")]
        [int32]
        $IssueId,

        # The key of the issue
        [Parameter(Mandatory,Position=0,ValueFromPipelineByPropertyName,ParameterSetName="Key")]
        [string]
        $IssueKey,

        # The key name for the property
        [Parameter(Mandatory,Position=1,ValueFromPipeline,ValueFromPipelineByPropertyName)]
        [AllowEmptyCollection()]
        [string[]]
        $Keys,

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    begin {
        $results = @()
    }
    process {
        if ($Keys.Count -gt 0) {
            $Keys | ForEach-Object {
                $issueToken = IIF ($PSCmdlet.ParameterSetName -eq "Id") $IssueId $IssueKey
                $functionPath = "/rest/api/2/issue/$issueToken/properties/$_"
                $verb = "DELETE"

                $method = New-Object RestMethod @($functionPath,$verb)
                $results += $method.Invoke($JiraContext)
            }
        }
    }
    end {
        #$results
    }
}