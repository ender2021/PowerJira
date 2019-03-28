# https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-version-post
function Invoke-JiraCreateVersion {
    [CmdletBinding()]
    param (
        # The ID of the project where the version will be created
        [Parameter(Mandatory=$true)]
        [int32]
        $ProjectId,

        # The name of the version to create.  Must be unique within the project.
        [Parameter(Mandatory=$true)]
        [ValidateLength(1,255)]
        [string]
        $Name,

        # A short description of the version
        [Parameter(Mandatory=$false)]
        [string]
        $Description,

        # The start date of the version. Will be converted to ISO 8601 format (yyyy-mm-dd). 
        [Parameter(Mandatory=$false)]
        [datetime]
        $StartDate,

        # The release date of the version. Will be converted to ISO 8601 format (yyyy-mm-dd). 
        [Parameter(Mandatory=$false)]
        [datetime]
        $ReleaseDate,

        # Returns all possible operations for the issue.
        [Parameter(Mandatory=$false)]
        [Switch]
        $ExpandOperations,
        
        # The JiraConnection object to use for the request
        [Parameter(Mandatory=$false)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/version"
    
        $body = @{
            projectId = $ProjectId
            name = $Name
        }
        if($PSBoundParameters.ContainsKey("Description")){$body.Add("description",$Description)}
        if($PSBoundParameters.ContainsKey("StartDate")){$body.Add("startDate",(Format-JiraRestDateTime $StartDate))}
        if($PSBoundParameters.ContainsKey("ReleaseDate")){$body.Add("releaseDate",(Format-JiraRestDateTime $ReleaseDate))}
        if($PSBoundParameters.ContainsKey("ExpandOperations")){$body.Add("expand","operations")}

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "POST" -Body $body
    }
}