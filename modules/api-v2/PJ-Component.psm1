#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-component-post
function Invoke-JiraCreateComponent {
    [CmdletBinding()]
    param (
        # The project Key of the project to add the component to
        [Parameter(Mandatory,Position=0)]
        [string]
        $ProjectKey,

        # The name for the component
        [Parameter(Mandatory,Position=1)]
        [ValidateLength(1,255)]
        [string]
        $Name,

        # Description of the component
        [Parameter(Position=2)]
        [string]
        $Description,

        # The AccountID of the component lead
        [Parameter(Position=3)]
        [string]
        $LeadAccountId,

        # Use this parameter to determine the default assignee logic for issues with this component
        [Parameter(Position=4)]
        [ValidateSet("PROJECT_LEAD","COMPONENT_LEAD","UNASSIGNED","PROJECT_DEFAULT")]
        [string]
        $DefaultAssignee="PROJECT_DEFAULT",

        # The JiraConnection object to use for the request
        [Parameter(Position=5)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/component"

        $body=@{
            project = $ProjectKey
            name = $Name
            assigneeType = $DefaultAssignee
        }
        if($PSBoundParameters.ContainsKey("Description")){$body.Add("description",$Description)}
        if($PSBoundParameters.ContainsKey("LeadAccountId")){$body.Add("leadAccountId",$LeadAccountId)}

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "POST" -Body $body
    }
}

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-component-id-get
function Invoke-JiraGetComponent {
    [CmdletBinding()]
    param (
        # The ID of the Component to retrieve
        [Parameter(Mandatory,Position=0)]
        [int32]
        $ComponentId,

        # The JiraConnection object to use for the request
        [Parameter(Position=1)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/component/$ComponentId"

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "GET"
    }
}

Export-ModuleMember -Function * -Variable *