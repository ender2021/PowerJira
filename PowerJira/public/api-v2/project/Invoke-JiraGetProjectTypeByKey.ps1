#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-project-type-projectTypeKey-get
#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-project-type-projectTypeKey-accessible-get
function Invoke-JiraGetProjectTypeByKey {
    [CmdletBinding()]
    param (
        # Get project type with this key. Valid values are ops, software, service_desk, business
        [Parameter(Mandatory,Position=0)]
        [ValidateSet("ops","software","service_desk","business")]
        $Key,

        # Set this flag to only return the project type if it is accessible to the current user
        [Parameter()]
        [switch]
        $Accessible,

        # The JiraConnection object to use for the request
        [Parameter(Position=1)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/project/type/$Key"
        if($PSBoundParameters.ContainsKey("Accessible")){$functionPath += "/accessible"}
        $verb = "GET"

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb
    }
}