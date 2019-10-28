#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-role-id-put
function Invoke-JiraUpdateProjectRolePartial {
    [CmdletBinding(DefaultParameterSetName="Name")]
    param (
        # The ID of the project role to update
        [Parameter(Mandatory,Position=0)]
        [int64]
        $ProjectRoleId,

        # The name of the role to create
        [Parameter(Mandatory,ParameterSetName="Name",Position=1)]
        [ValidateLength(1,255)]
        [string]
        $Name,

        # Option role description
        [Parameter(Mandatory,ParameterSetName="Description",Position=1)]
        [string]
        $Description,
        
        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/role/$ProjectRoleId"
        $verb = "POST"

        $body = New-Object RestMethodJsonBody
        if($PSBoundParameters.ContainsKey("Name")){$body.Add("name",$Name)}
        if($PSBoundParameters.ContainsKey("Description")){$body.Add("description",$Description)}

        $method = New-Object BodyRestMethod @($functionPath,$verb,$body)
        $method.Invoke($JiraContext)
    }
}