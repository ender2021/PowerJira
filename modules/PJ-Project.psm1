#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-project-projectIdOrKey-versions-get
function Invoke-JiraGetProjectVersions {
    [CmdletBinding()]
    param (
        # The project ID or project key (case sensitive).
        [Parameter(Mandatory=$true)]
        [string]
        $ProjectIdOrKey,

        # Use expand to include additional information in the response.
        [Parameter(Mandatory=$false)]
        [string[]]
        $Expand,
        
        # The JiraConnection object to use for the request
        [Parameter(Mandatory=$false)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/project/$ProjectIdOrKey/versions"

        $body = @{}
        if($PSBoundParameters.ContainsKey("Expand")){$body.Add("expand",$Expand -join ",")}

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "GET" -Body $body
    }
}

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-project-projectIdOrKey-get
function Invoke-JiraGetProject {
    [CmdletBinding()]
    param (
        # The project ID or project key (case sensitive).
        [Parameter(Mandatory=$true)]
        [string]
        $ProjectIdOrKey,

        # Use expand to include additional information in the response.
        [Parameter(Mandatory=$false)]
        [string[]]
        $Expand,
        
        # The JiraConnection object to use for the request
        [Parameter(Mandatory=$false)]
        [hashtable]
        $JiraConnection
    )
    $functionPath = "/rest/api/2/project/$ProjectIdOrKey"
    
    $body = @{}
    if($PSBoundParameters.ContainsKey("Expand")){$body.Add("expand",$Expand -join ",")}

    Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "GET" -Body $body
}

Export-ModuleMember -Function * -Variable *