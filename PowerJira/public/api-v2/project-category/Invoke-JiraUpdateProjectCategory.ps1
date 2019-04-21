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

        # The JiraConnection object to use for the request
        [Parameter(Position=3)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/projectCategory/$CategoryId"
        $verb = "PUT"

        $body=@{}
        if($PSBoundParameters.ContainsKey("Name")){$body.Add("name",$Name)}
        if($PSBoundParameters.ContainsKey("Description")){$body.Add("description",$Description)}

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Body $body
    }
}