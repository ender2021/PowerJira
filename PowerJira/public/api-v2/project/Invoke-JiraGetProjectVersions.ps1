#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-project-projectIdOrKey-versions-get
function Invoke-JiraGetProjectVersions {
    [CmdletBinding()]
    param (
        # The project ID or project key (case sensitive).
        [Parameter(Mandatory=$true)]
        [string]
        $ProjectIdOrKey,

        # Returns all possible operations for the issue.
        [Parameter(Mandatory=$false)]
        [Switch]
        $ExpandOperations,
        
        # The JiraConnection object to use for the request
        [Parameter(Mandatory=$false)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/project/$ProjectIdOrKey/versions"

        $body = @{}
        if($PSBoundParameters.ContainsKey("ExpandOperations")){$body.Add("expand","operations")}

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "GET" -Body $body
    }
}