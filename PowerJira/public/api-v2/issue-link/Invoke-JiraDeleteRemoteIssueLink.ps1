#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-remotelink-linkId-delete
#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-remotelink-delete
function Invoke-JiraDeleteRemoteIssueLink {
    [CmdletBinding(DefaultParameterSetName="ById")]
    param (
        # The issue Id or Key
        [Parameter(Mandatory,Position=0)]
        [string]
        $IssueIdOrKey,

        # The ID of the remote link
        [Parameter(Mandatory,Position=1,ParameterSetName="ById")]
        [string]
        $RemoteLinkId,

        # The Global Id of the link to delete
        [Parameter(Mandatory,Position=1,ParameterSetName="ByGlobal")]
        [string]
        $GlobalId,

        # The JiraConnection object to use for the request
        [Parameter(Position=2)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issue/$IssueIdOrKey/remotelink"
        if($PSBoundParameters.ContainsKey("RemoteLinkId")){$functionPath += "/$RemoteLinkId"}
        $verb = "DELETE"
        
        $query = @{}
        if($PSBoundParameters.ContainsKey("GlobalId")){
            $query.Add("globalId",$GlobalId)
        }

        Invoke-JiraRestRequest $JiraConnection $functionPath $verb -Query $query
    }
}