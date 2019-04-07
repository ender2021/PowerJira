#/rest/api/2/worklog/updated
function Invoke-JiraGetUpdatedWorklogIds {
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
        $functionPath = "/rest/api/2/worklog/updated"
        $verb = "GET"

        $query=@{}
        if($PSCmdlet.ParameterSetName -eq "DateTime"){$query.Add("since",(Format-UnixTimestamp $StartDateTime))}
        if($PSCmdlet.ParameterSetName -eq "Unix"){$query.Add("since",$StartUnixStamp)}

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod $verb -Query $query
    }
}