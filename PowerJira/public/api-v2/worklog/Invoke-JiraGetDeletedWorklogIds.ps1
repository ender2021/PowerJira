#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-worklog-deleted-get
function Invoke-JiraGetDeletedWorklogIds {
    [CmdletBinding(DefaultParameterSetName="Unix")]
    param (
        # The start date/time to use for returning the deleted list
        [Parameter(Mandatory,Position=0,ParameterSetName="DateTime")]
        [datetime]
        $StartDateTime,

        # The start date/time to use for returning the deleted list, in Unix timestamp format
        [Parameter(Position=0,ParameterSetName="Unix")]
        [int64]
        $StartUnixStamp=0,

        # The JiraConnection object to use for the request
        [Parameter(Position=1)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/worklog/deleted"
        $verb = "GET"

        $query=@{}
        if($PSCmdlet.ParameterSetName -eq "DateTime"){$query.Add("since",(Format-UnixTimestamp $StartDateTime))}
        if($PSCmdlet.ParameterSetName -eq "Unix"){$query.Add("since",$StartUnixStamp)}

        Invoke-JiraRestRequest $JiraConnection $functionPath $verb -Query $query
    }
}