#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-version-id-put
function Invoke-JiraUpdateVersion {
    [CmdletBinding()]
    param (
        # The ID of the version to update
        [Parameter(Mandatory=$true)]
        [int32]
        $VersionId,

        # The updated name of the version.  Must be unique within the project.
        [Parameter(Mandatory=$false)]
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

        # Indicates that the version is archived
        [Parameter(Mandatory=$false)]
        [bool]
        $Archived,

        # Indicates that the version is released
        [Parameter(Mandatory=$false)]
        [bool]
        $Released,

        # The ID of the version to move unfixed issues into
        [Parameter(Mandatory=$false)]
        [int32]
        $UnfixedIssuesVersionId,

        # Returns all possible operations for the issue.
        [Parameter(Mandatory=$false)]
        [Switch]
        $ExpandOperations,
        
        # Returns the count of issues in this version for each of the status categories to do,
        # in progress, done, and unmapped. The unmapped property contains a count of issues with
        # a status other than to do, in progress, and done.
        [Parameter(Mandatory=$false)]
        [Switch]
        $ExpandIssuesStatusCount,
        
        # The JiraConnection object to use for the request
        [Parameter(Mandatory=$false)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/version/$VersionId"
        
        $expand = @()
        if($PSBoundParameters.ContainsKey("ExpandOperations")){$expand += "operations"}
        if($PSBoundParameters.ContainsKey("ExpandIssuesStatusCount")){$expand += "issuesstatus"}
        
        $body = @{
            id = $VersionId
        }
        if($expand.Count -gt 0) {$body.Add("expand",$expand -join ",")}
        if($PSBoundParameters.ContainsKey("Name")){$body.Add("name",$Name)}
        if($PSBoundParameters.ContainsKey("Description")){$body.Add("description",$Description)}
        if($PSBoundParameters.ContainsKey("StartDate")){$body.Add("startDate",(Format-JiraRestDateTime $StartDate))}
        if($PSBoundParameters.ContainsKey("ReleaseDate")){$body.Add("releaseDate",(Format-JiraRestDateTime $ReleaseDate))}
        if($PSBoundParameters.ContainsKey("Archived")){$body.Add("archived",$Archived)}
        if($PSBoundParameters.ContainsKey("Released")){$body.Add("released",$Released)}
        if($PSBoundParameters.ContainsKey("UnfixedIssuesVersionId")) {$body.Add("moveUnfixedIssuesTo",$UnfixedIssuesVersionId)}

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "PUT" -Body $body
    }
}