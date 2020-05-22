#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-auditing-record-get
function Invoke-JiraGetAuditRecords {
    [CmdletBinding(DefaultParameterSetName="Default")]
    param (
        # A search query to filter the results
        [Parameter(Position=0,ParameterSetName="Default")]
        [Parameter(Position=0,ParameterSetName="DateFilter")]
        [string]
        $Filter,

        # Use to filter results by date; this is the start of the range
        [Parameter(Mandatory,Position=1,ParameterSetName="DateFilter")]
        [datetime]
        $From,

        # Use to filter results by date; this is the end of the range
        [Parameter(Mandatory,Position=2,ParameterSetName="DateFilter")]
        [datetime]
        $To,

        # The index of the record to return first
        [Parameter(Position=1,ParameterSetName="Default")]
        [Parameter(Position=3,ParameterSetName="DateFilter")]
        [int32]
        $StartAt=0,

        # The maximum number of records to return.  Cannot exceed 1000.
        [Parameter(Position=2,ParameterSetName="Default")]
        [Parameter(Position=4,ParameterSetName="DateFilter")]
        [ValidateRange(1,1000)]
        [int32]
        $MaxResults=1000,

        # The JiraContext object to use for the request
        [Parameter()]
        [object]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/auditing/record"
        $verb = "GET"

        $query = New-PACRestMethodQueryParams
        if($PSBoundParameters.ContainsKey("Filter")){$query.Add("filter",$Filter)}
        if($PSBoundParameters.ContainsKey("StartAt")){$query.Add("offset",$StartAt)}
        if($PSBoundParameters.ContainsKey("MaxResults")){$query.Add("limit",$MaxResults)}
        if($PSBoundParameters.ContainsKey("From")){
            $query.Add("from",([JiraDateTime]::SimpleFormat($From)))
            $query.Add("to",([JiraDateTime]::SimpleFormat($To)))
        }

        $method = New-PACRestMethod $functionPath $verb $query
        $method.Invoke($JiraContext)
    }
}