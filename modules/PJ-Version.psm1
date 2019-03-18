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

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "POST" -Body $body
    }
}

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

        # The JiraConnection object to use for the request
        [Parameter(Mandatory=$false)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/version/$VersionId"
        
        $body = @{
            id = $VersionId
        }
        if($PSBoundParameters.ContainsKey("Description")){$body.Add("description",$Description)}
        if($PSBoundParameters.ContainsKey("StartDate")){$body.Add("startDate",(Format-JiraRestDateTime $StartDate))}
        if($PSBoundParameters.ContainsKey("ReleaseDate")){$body.Add("releaseDate",(Format-JiraRestDateTime $ReleaseDate))}
        if($PSBoundParameters.ContainsKey("Archived")){$body.Add("archived",$Archived)}
        if($PSBoundParameters.ContainsKey("Released")){$body.Add("released",$Released)}
        if($PSBoundParameters.ContainsKey("UnfixedIssuesVersionId")) {$body.Add("moveUnfixedIssuesTo",$UnfixedIssuesVersionId)}

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "PUT" -Body $body
    }
}

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-version-id-removeAndSwap-post
function Invoke-JiraDeleteVersion {
    [CmdletBinding()]
    param (
        # The ID of the version to update
        [Parameter(Mandatory=$true)]
        [int32]
        $VersionId,

        # Replacement version for issues with this version in the fixVersions field
        [Parameter(Mandatory=$false)]
        [int32]
        $FixTargetVersionId,

        # Replacement version for issues with this version in the affectsVersions field
        [Parameter(Mandatory=$false)]
        [int32]
        $AffectedTargetVersionId,

        # The JiraConnection object to use for the request
        [Parameter(Mandatory=$false)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/version/$VersionId/removeAndSwap"
        
        $body = @{}
        if($PSBoundParameters.ContainsKey("FixTargetVersionId")){$body.Add("moveFixIssuesTo",$FixTargetVersionId)}
        if($PSBoundParameters.ContainsKey("AffectedTargetVersionId")){$body.Add("moveAffectedIssuesTo",$AffectedTargetVersionId)}
        
        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "POST" -Body $body
    }
}

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-version-id-GET
function Invoke-JiraGetVersion {
    [CmdletBinding()]
    param (
        # The ID of the version to update
        [Parameter(Mandatory=$true)]
        [int32]
        $VersionId,

        # The JiraConnection object to use for the request
        [Parameter(Mandatory=$false)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/version/$VersionId"
        
        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "GET"
    }
}

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-version-id-move-post
function Invoke-JiraMoveVersion {
    [CmdletBinding()]
    param (
        # The ID of the version to update
        [Parameter(Mandatory=$true)]
        [int32]
        $VersionId,

        # Move this version to immediately after another specified target version. Provide the self link of the target.
        [Parameter(Mandatory=$true,ParameterSetName="After")]
        [uri]
        $After,

        # Move this version to a new position relative to the list or itself.
        [Parameter(Mandatory=$true,ParameterSetName="Position")]
        [ValidateSet("Earlier","Later","First","Last")]
        [string]
        $Position,
        
        # The JiraConnection object to use for the request
        [Parameter(Mandatory=$false)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/version/$VersionId/move"
        
        $body = @{}
        if($PSBoundParameters.ContainsKey("After")){$body.Add("after",$After)} else {$body.Add("position",$Position)}

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "POST" -Body $body
    }
}

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-version-id-mergeto-moveIssuesTo-put
function Invoke-JiraMergeVersion {
    [CmdletBinding()]
    param (
        # The ID of the version to merge from
        [Parameter(Mandatory=$true)]
        [int32]
        $SourceVersionId,

        # The ID of the version to merge into
        [Parameter(Mandatory=$true)]
        [int32]
        $TargetVersionId,

        # The JiraConnection object to use for the request
        [Parameter(Mandatory=$false)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/version/$SourceVersionId/mergeto/$TargetVersionId"
    
        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "PUT"
    }
}

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-version-id-relatedIssueCounts-get
function Invoke-JiraGetVersionRelatedIssueCounts {
    [CmdletBinding()]
    param (
        # The ID of the version
        [Parameter(Mandatory=$true)]
        [int32]
        $VersionId,

        # The JiraConnection object to use for the request
        [Parameter(Mandatory=$false)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/version/$VersionId/relatedIssueCounts"
    
        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "GET"
    }
}

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-version-id-unresolvedIssueCount-get
function Invoke-JiraGetVersionUnresolvedIssueCount {
    [CmdletBinding()]
    param (
        # The ID of the version
        [Parameter(Mandatory=$true)]
        [int32]
        $VersionId,

        # The JiraConnection object to use for the request
        [Parameter(Mandatory=$false)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/version/$VersionId/unresolvedIssueCount"
    
        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "GET"
    }
}

Export-ModuleMember -Function * -Variable *