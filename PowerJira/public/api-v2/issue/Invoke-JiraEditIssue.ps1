#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-put
function Invoke-JiraEditIssue {
    [CmdletBinding(DefaultParameterSetName="Id")]
    param (
        # The ID of the issue
        [Parameter(Mandatory,Position=0,ValueFromPipeline,ValueFromPipelineByPropertyName,ParameterSetName="Id")]
        [int32]
        $Id,

        # The key of the issue
        [Parameter(Mandatory,Position=0,ValueFromPipeline,ValueFromPipelineByPropertyName,ParameterSetName="Key")]
        [string]
        $Key,

        # Used to make simple updates to fields on this issue
        [Parameter(Position=1,ValueFromPipelineByPropertyName)]
        [hashtable]
        $Fields,

        # Used to make complex updates to issue fields
        [Parameter(Position=2,ValueFromPipelineByPropertyName)]
        [hashtable]
        $Update,

        # Optional history metadata
        [Parameter(Position=3,ValueFromPipelineByPropertyName)]
        [hashtable]
        $HistoryMetadata,

        # Add/set arbitrary issue properties
        [Parameter(Position=4,ValueFromPipelineByPropertyName)]
        [hashtable]
        $Properties,

        # DDisables issue notifications for this update
        [Parameter(Position=5,ValueFromPipelineByPropertyName)]
        [Switch]
        $DisableNotifications,

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    begin {
        $results = @()
    }
    process {
        $issueToken = IIF ($PSCmdlet.ParameterSetName -eq "Id") $Id $Key
        $functionPath = "/rest/api/2/issue/$issueToken"
        $verb = "PUT"

        $query = New-Object RestMethodQueryParams @{
            notifyUsers = !$DisableNotifications
        }

        $body = New-Object RestMethodJsonBody
        if($PSBoundParameters.ContainsKey("Fields")){$body.Add("fields",$Fields)}
        if($PSBoundParameters.ContainsKey("Update")){$body.Add("update",$Update)}
        if($PSBoundParameters.ContainsKey("HistoryMetadata")){$body.Add("historyMetadata",$HistoryMetadata)}
        if($PSBoundParameters.ContainsKey("Properties")){$body.Add("properties",$Properties)}

        $method = New-Object BodyRestMethod @($functionPath,$verb,$query,$body)
        $results += $method.Invoke($JiraContext)
    }
    end {
        $results
    }
}