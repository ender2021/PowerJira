$JiraVersionExpand = @("operations","issuesstatus")

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-version-id-put
function Invoke-JiraUpdateVersion {
    [CmdletBinding()]
    param (
        # The ID of the version to update
        [Parameter(Mandatory,Position=0)]
        [int32]
        $VersionId,

        # The updated name of the version.  Must be unique within the project.
        [Parameter(Position=1)]
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

        # Indicates that the version is archived
        [Parameter(Position=5)]
        [bool]
        $Archived,

        # Indicates that the version is released
        [Parameter(Position=6)]
        [bool]
        $Released,

        # The ID of the version to move unfixed issues into
        [Parameter(Position=7)]
        [int32]
        $UnfixedIssuesVersionId,

        # Used to expand additional attributes
        [Parameter(Position=8)]
        [ValidateScript({ Compare-StringArraySubset $JiraVersionExpand $_ })]
        [string[]]
        $Expand,
        
        # The JiraConnection object to use for the request
        [Parameter(Position=9)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/version/$VersionId"
        $verb = "PUT"

        $body = @{
            id = $VersionId
        }
        if($PSBoundParameters.ContainsKey("Expand")){$body.Add("expand",$Expand -join ",")}
        if($PSBoundParameters.ContainsKey("Name")){$body.Add("name",$Name)}
        if($PSBoundParameters.ContainsKey("Description")){$body.Add("description",$Description)}
        if($PSBoundParameters.ContainsKey("StartDate")){$body.Add("startDate",(Format-JiraRestDateTime $StartDate))}
        if($PSBoundParameters.ContainsKey("ReleaseDate")){$body.Add("releaseDate",(Format-JiraRestDateTime $ReleaseDate))}
        if($PSBoundParameters.ContainsKey("Archived")){$body.Add("archived",$Archived)}
        if($PSBoundParameters.ContainsKey("Released")){$body.Add("released",$Released)}
        if($PSBoundParameters.ContainsKey("UnfixedIssuesVersionId")) {$body.Add("moveUnfixedIssuesTo",$UnfixedIssuesVersionId)}

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod $verb -Query $query -Body $body
    }
}