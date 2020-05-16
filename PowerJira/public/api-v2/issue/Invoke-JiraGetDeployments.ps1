#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-get
function Invoke-JiraGetDeployments {
    param (
        # The ID of the issue
        [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)]
        [int32]
        $Id
    )
    begin {
        $results = @()
    }
    process {
        $functionPath = "/jsw/graphql?operation=DevDetailsDialog"
        $verb = "POST"

        $query = New-Object RestMethodQueryParams

        $gqlQuery = @'
query DevDetailsDialog ($issueId: ID!) {
	developmentInformation(issueId: $issueId){
		details {
			deploymentProviders {
				deployments {
					displayName
					url
					state
					lastUpdated
					pipelineId
					pipelineDisplayName
					pipelineUrl
					environment {
						id
						type
						displayName
					}
				}
			}
		}
	}
}
'@

        $body = New-Object RestMethodJsonBody @{
            operationName = "DevDetailsDialog"
            query         = $gqlQuery
            variables     = @{
                issueId = $Id
            }
        }

        $method = New-Object BodyRestMethod @($functionPath, $verb, $query, $body) 
        $results += $method.Invoke($JiraContext)
    }
    end {
        $results.data.developmentInformation.details.deploymentProviders.deployments
    }
}