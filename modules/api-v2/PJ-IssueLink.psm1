#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issueLink-post
function Invoke-JiraCreateIssueLink {
    [CmdletBinding(DefaultParameterSetName="ByName")]
    param (
        # The issue Id or Key for the issue on the "inward" side of the link
        [Parameter(Mandatory,Position=0)]
        [string]
        $InwardIssueIdOrKey,

        # The ID of the link type to create between the issues
        [Parameter(Mandatory,Position=1,ParameterSetName="ById")]
        [Parameter(Mandatory,Position=1,ParameterSetName="ById,SimpleComment")]
        [Parameter(Mandatory,Position=1,ParameterSetName="ById,ComplexComment")]
        [int32]
        $LinkTypeId,

        # The ID of the link type to create between the issues
        [Parameter(Mandatory,Position=1,ParameterSetName="ByName")]
        [Parameter(Mandatory,Position=1,ParameterSetName="ByName,SimpleComment")]
        [Parameter(Mandatory,Position=1,ParameterSetName="ByName,ComplexComment")]
        [string]
        $LinkTypeName,

        # The issue Id or Key for the issue on the "outward" side of the link
        [Parameter(Mandatory,Position=2)]
        [string]
        $OutwardIssueIdOrKey,

        # A comment to add along with the issue link
        [Parameter(Mandatory,Position=3,ParameterSetName="ById,SimpleComment")]
        [Parameter(Mandatory,Position=3,ParameterSetName="ByName,SimpleComment")]
        [string]
        $Comment,

        # The visibility setting for a comment
        [Parameter(Mandatory,Position=3,ParameterSetName="ById,ComplexComment")]
        [Parameter(Mandatory,Position=3,ParameterSetName="ByName,ComplexComment")]
        [hashtable]
        $CommentObject,

        # The JiraConnection object to use for the request
        [Parameter(Position=4)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issueLink"

        $outwardIssue=@{}
        $inwardIssue=@{}
        if(Test-Id $OutwardIssueIdOrKey) {$outwardIssue.Add("id",$OutwardIssueIdOrKey)} else {$outwardIssue.Add("key",$OutwardIssueIdOrKey)}
        if(Test-Id $InwardIssueIdOrKey) {$inwardIssue.Add("id",$InwardIssueIdOrKey)} else {$inwardIssue.Add("key",$InwardIssueIdOrKey)}

        $linkType=@{}
        if($PSBoundParameters.ContainsKey("LinkTypeId")){$linkType.Add("id",$LinkTypeId)}
        if($PSBoundParameters.ContainsKey("LinkTypeName")){$linkType.Add("name",$LinkTypeName)}
        
        $body=@{
            outwardIssue = $outwardIssue
            inwardIssue = $inwardIssue
            type = $linkType
        }
        if($PSBoundParameters.ContainsKey("Comment")){$body.Add("comment",@{body=$Comment})}
        if($PSBoundParameters.ContainsKey("CommentObject")){$body.Add("comment",$CommentObject)}

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "POST" -Body $body
    }
}

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issueLink-linkId-get
function Invoke-JiraGetIssueLink {
    [CmdletBinding()]
    param (
        # The ID of the issue link to be retrieved
        [Parameter(Mandatory,Position=0)]
        [int32]
        $LinkId,

        # The JiraConnection object to use for the request
        [Parameter(Position=1)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/issueLink/$LinkId"

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "GET" -Body $body
    }
}

Export-ModuleMember -Function * -Variable *