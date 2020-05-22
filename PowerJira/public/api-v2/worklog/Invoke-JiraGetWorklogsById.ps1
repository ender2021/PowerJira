$JiraWorklogExpand = @("properties")

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-worklog-list-post
function Invoke-JiraGetWorklogsById {
    [CmdletBinding()]
    param (
        # An array of worklog IDs
        [Parameter(Mandatory,Position=0)]
        [ValidateScript({ $_.Count -le 1000 })]
        [int32[]]
        $WorklogIds,

        # Used to expand additional attributes
        [Parameter(Position=1)]
        [ValidateScript({ Compare-StringArraySubset $JiraWorklogExpand $_ })]
        [string[]]
        $Expand,

        # The JiraContext object to use for the request
        [Parameter()]
        [object]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/worklog/list"
        $verb = "POST"

        $query = New-PACRestMethodQueryParams
        if($PSBoundParameters.ContainsKey("Expand")){$query.Add("expand",$Expand -join ",")}

        $body = New-PACRestMethodJsonBody @{
            ids = $WorklogIds
        }

        $method = New-PACRestMethod $functionPath $verb $query $body
        $method.Invoke($JiraContext)
    }
}