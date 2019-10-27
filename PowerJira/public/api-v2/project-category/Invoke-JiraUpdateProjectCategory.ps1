#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-projectCategory-put
function Invoke-JiraUpdateProjectCategory {
    [CmdletBinding()]
    param (
        # The id of the category to retrieve
        [Parameter(Mandatory,Position=0)]
        [int64]
        $CategoryId,

        # A name for the category
        [Parameter(Position=1)]
        [string]
        $Name,

        # A description for the category
        [Parameter(Position=2)]
        [string]
        $Description,

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/projectCategory/$CategoryId"
        $verb = "PUT"

        $body = New-Object RestMethodJsonBody
        if($PSBoundParameters.ContainsKey("Name")){$body.Add("name",$Name)}
        if($PSBoundParameters.ContainsKey("Description")){$body.Add("description",$Description)}

        $method = New-Object BodyRestMethod @($functionPath,$verb,$body)
        $method.Invoke($JiraContext)
    }
}