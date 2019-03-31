$NotificationSchemeExpand = @("all","field","group","notificationSchemeEvents","projectRole","user")

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-notificationscheme-id-get
function Invoke-JiraGetNotificationScheme {
    [CmdletBinding()]
    param (
        # The ID of the scheme to retrieve
        [Parameter(Mandatory,Position=0)]
        [int64]
        $SchemeId,

        # Select which fields on the returned object will be expanded
        [Parameter(Position=1)]
        [ValidateScript({ Compare-StringArraySubset $NotificationSchemeExpand $_ })]
        [string[]]
        $Expand,

        # The JiraConnection object to use for the request
        [Parameter(Position=2)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/notificationscheme/$SchemeId"

        $body=@{}
        if($PSBoundParameters.ContainsKey("Expand")){$body.Add("expand",$Expand -join ",")}

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "GET" -Body $body
    }
}