#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-remotelink-post
function Invoke-JiraCreateOrUpdateRemoteIssueLink {
    [CmdletBinding()]
    param (
        # The issue Id or Key
        [Parameter(Mandatory,Position=0)]
        [string]
        $IssueIdOrKey,

        # The linked object
        [Parameter(Mandatory,Position=1)]
        [hashtable]
        $RemoteObject,

        # The global ID to set for the remote link
        [Parameter(Position=2)]
        [ValidateLength(1,255)]
        [string]
        $GlobalId,

        # The Jira remote application this issue is related to.  Use New-JiraRemoteApplication for a properly formatted object
        [Parameter(Position=3)]
        [hashtable]
        $Application,

        # A string describing the relationship
        [Parameter(Position=4)]
        [string]
        $Relationship,

        # Additional properties to add to the remote application
        [Parameter(Position=5)]
        [hashtable]
        $AdditionalProperties,

        # The JiraConnection object to use for the request
        [Parameter(Position=6)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issue/$IssueIdOrKey/remotelink"
        $verb = "POST"

        $body=@{
            object = $RemoteObject
        }
        if($PSBoundParameters.ContainsKey("GlobalId")){$body.Add("globalId",$GlobalId)}
        if($PSBoundParameters.ContainsKey("Relationship")){$body.Add("relationship",$Relationship)}
        if($PSBoundParameters.ContainsKey("Application")){$body.Add("application",$Application)}
        if($PSBoundParameters.ContainsKey("AdditionalProperties")){$body += $AdditionalProperties}

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod $verb -Body $body
    }
}