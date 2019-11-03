#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issueLinkType-issueLinkTypeId-put
function Invoke-JiraUpdateIssueLinkType {
    [CmdletBinding(DefaultParameterSetName="Name")]
    param (
        # The Id of the Issue Link Type
        [Parameter(Mandatory,Position=0)]
        [string]
        $LinkTypeId,

        # The name of the link type
        [Parameter(Position=1)]
        [string]
        $Name,

        # The inward description of the relationship (e.g. "Duplicated by")
        [Parameter(Position=2)]
        [string]
        $Inward,

        #  The outward description of the relationship (e.g. "Duplicates")
        [Parameter(Position=3)]
        [string]
        $Outward,

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/issueLinkType/$LinkTypeId"
        $verb = "PUT"

        $body = New-Object RestMethodJsonBody
        if($PSBoundParameters.ContainsKey("Name")){$body.Add("name",$Name)}
        if($PSBoundParameters.ContainsKey("Inward")){$body.Add("inward",$Inward)}
        if($PSBoundParameters.ContainsKey("Outward")){$body.Add("outward",$Outward)}

        $method = New-Object BodyRestMethod @($functionPath,$verb,$body)
        $method.Invoke($JiraContext)
    }
}