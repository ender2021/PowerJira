$JiraProjectExpand = @("description","issueTypes","lead","projectKeys")

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-project-projectIdOrKey-get
function Invoke-JiraGetProject {
    [CmdletBinding()]
    param (
        # The project ID or project key (case sensitive).
        [Parameter(Mandatory,Position=0)]
        [string]
        $ProjectIdOrKey,

        # Used to expand additional attributes
        [Parameter(Position=1)]
        [ValidateScript({ Compare-StringArraySubset $JiraProjectExpand $_ })]
        [string[]]
        $Expand,
        
        # The JiraConnection object to use for the request
        [Parameter(Position=2)]
        [hashtable]
        $JiraConnection
    )
    $functionPath = "/rest/api/2/project/$ProjectIdOrKey"
    
    $query = @{}
    if($PSBoundParameters.ContainsKey("Expand")){$query.Add("expand",$Expand -join ",")}

    Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "GET" -QueryParams $query
}