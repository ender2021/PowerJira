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

        # The JiraConnection object to use for the request
        [Parameter(Position=2)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/worklog/list"
        $verb = "POST"

        $query = @{}
        if($PSBoundParameters.ContainsKey("Expand")){$query.Add("expand",$Expand -join ",")}

        $body=@{
            ids = $WorklogIds
        }

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod $verb -Query $query -Body $body
    }
}