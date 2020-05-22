$JiraVersionExpand = @("operations","issuesstatus")

# https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-version-post
function Invoke-JiraCreateVersion {
    [CmdletBinding()]
    param (
        # The ID of the project where the version will be created
        [Parameter(Mandatory,Position=0)]
        [int32]
        $ProjectId,

        # The name of the version to create.  Must be unique within the project.
        [Parameter(Mandatory,Position=1)]
        [ValidateLength(1,255)]
        [string]
        $Name,

        # A short description of the version
        [Parameter(Position=2)]
        [string]
        $Description,

        # The start date of the version. Will be converted to ISO 8601 format (yyyy-mm-dd). 
        [Parameter(Position=3)]
        [datetime]
        $StartDate,

        # The release date of the version. Will be converted to ISO 8601 format (yyyy-mm-dd). 
        [Parameter(Position=4)]
        [datetime]
        $ReleaseDate,

        # Used to expand additional attributes
        [Parameter(Position=5)]
        [ValidateScript({ Compare-StringArraySubset $JiraVersionExpand $_ })]
        [string[]]
        $Expand,
        
        # The JiraContext object to use for the request
        [Parameter()]
        [object]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/version"
        $verb = "POST"

        $body = New-PACRestMethodJsonBody @{
            projectId = $ProjectId
            name = $Name
        }
        if($PSBoundParameters.ContainsKey("Expand")){$body.Add("expand",$Expand -join ",")}
        if($PSBoundParameters.ContainsKey("Description")){$body.Add("description",$Description)}
        if($PSBoundParameters.ContainsKey("StartDate")){$body.Add("startDate",[JiraDateTime]::ComplexFormat($StartDate))}
        if($PSBoundParameters.ContainsKey("ReleaseDate")){$body.Add("releaseDate",[JiraDateTime]::ComplexFormat($ReleaseDate))}

        $method = New-PACRestMethod $functionPath $verb $null $body
        $method.Invoke($JiraContext)
    }
}