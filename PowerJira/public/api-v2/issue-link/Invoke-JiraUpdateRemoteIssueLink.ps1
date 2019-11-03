#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-remotelink-linkId-put
function Invoke-JiraUpdateRemoteIssueLink {
    [CmdletBinding()]
    param (
        # The issue Id or Key
        [Parameter(Mandatory,Position=0)]
        [string]
        $IssueIdOrKey,

        # The ID of the remote link
        [Parameter(Mandatory,Position=1)]
        [string]
        $RemoteLinkId,

        # The linked object
        [Parameter(Mandatory,Position=2)]
        [hashtable]
        $RemoteObject,

        # The global ID to set for the remote link
        [Parameter(Position=3)]
        [ValidateLength(1,255)]
        [string]
        $GlobalId,

        # The Jira remote application this issue is related to.  Use New-JiraRemoteApplication for a properly formatted object
        [Parameter(Position=4)]
        [hashtable]
        $Application,

        # A string describing the relationship
        [Parameter(Position=5)]
        [string]
        $Relationship,

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/issue/$IssueIdOrKey/remotelink/$RemoteLinkId"
        $verb = "PUT"

        $body = New-Object RestMethodJsonBody @{
            object = $RemoteObject
        }
        if($PSBoundParameters.ContainsKey("GlobalId")){$body.Add("globalId",$GlobalId)}
        if($PSBoundParameters.ContainsKey("Relationship")){$body.Add("relationship",$Relationship)}
        if($PSBoundParameters.ContainsKey("Application")){$body.Add("application",$Application)}

        $method = New-Object BodyRestMethod @($functionPath,$verb,$body)
        $method.Invoke($JiraContext)
    }
}