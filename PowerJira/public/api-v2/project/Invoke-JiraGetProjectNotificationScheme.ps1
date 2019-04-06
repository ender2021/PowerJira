$JiraNotificationSchemeExpand = @("all","field","group","notificationSchemeEvents","projectRole","user")

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-project-projectKeyOrId-notificationscheme-get
function Invoke-JiraGetProjectNotificationScheme {
    [CmdletBinding()]
    param (
        # The project Id or Key
        [Parameter(Mandatory,Position=0)]
        [string]
        $ProjectIdOrKey,

        # Used to expand additional attributes
        [Parameter(Position=1)]
        [ValidateScript({ Compare-StringArraySubset $JiraNotificationSchemeExpand $_ })]
        [string[]]
        $Expand,

        # The JiraConnection object to use for the request
        [Parameter(Position=2)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/project/$ProjectIdOrKey/notificationscheme"

        $query = @{}
        if($PSBoundParameters.ContainsKey("Expand")){$query.Add("expand",$Expand -join ",")}

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "GET" -QueryParams $query
    }
}