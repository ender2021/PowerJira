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

        # The JiraContext object to use for the request
        [Parameter()]
        [object]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/issue/$IssueIdOrKey/remotelink"
        if($PSBoundParameters.ContainsKey("RemoteLinkId")){$functionPath += "/$RemoteLinkId"}
        $verb = "DELETE"
        
        $query = New-PACRestMethodQueryParams
        if($PSBoundParameters.ContainsKey("GlobalId")){
            $query.Add("globalId",$GlobalId)
        }

        $method = New-PACRestMethod $functionPath $verb $query
        $method.Invoke($JiraContext)
    }
}