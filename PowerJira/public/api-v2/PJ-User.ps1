# https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-myself-get
function Invoke-JiraGetCurrentUser {
    [CmdletBinding()]
    param (
        # Expand groups attribute
        [Parameter(Mandatory=$false)]
        [Switch]
        $ExpandGroups,

        # Expand applicationRoles attribute
        [Parameter(Mandatory=$false)]
        [Switch]
        $ExpandApplicationRoles,

        # The JiraConnection object to use for the request
        [Parameter(Mandatory=$false)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/myself"

        $expand = @()
        $body = @{}
        if($PSBoundParameters.ContainsKey("ExpandGroups")){$expand += "groups"} 
        if($PSBoundParameters.ContainsKey("ExpandApplicationRoles")){$expand += "applicationRoles"}
        if($expand.Count -gt 0) {$body.Add("expand",$expand -join ",")}
    
        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "GET" -Body $body
    }
}

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-user-search-get
function Invoke-JiraFindUsers {
    [CmdletBinding()]
    param (
        # A string will be used to search for users (will match against name and email address), must match from start of words
        [Parameter(Mandatory,Position=0)]
        [string]
        $SearchTerm,

        # The list index to start at if results are to be paginated
        [Parameter(Position=1)]
        [int32]
        $StartAt=0,

        # The Maximum results to be returned with the request
        [Parameter(Position=2)]
        [ValidateRange(1,1000)]
        [int32]
        $MaxResults=50,

        # The JiraConnection object to use for the request
        [Parameter()]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/user/search"

        $body=@{
            query = $SearchTerm
            startAt = $StartAt
            maxResults = $MaxResults
        }

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "GET" -Body $body
    }
}

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-user-get
function Invoke-JiraGetUser {
    [CmdletBinding()]
    param (
        # The accountID of the user to retrieve
        [Parameter(Mandatory,Position=0)]
        [string]
        $AccountId,

        # Set this flag to expand the user's group membership
        [Parameter(Position=1)]
        [switch]
        $ExpandGroups,

        # Set this flag to expand the user's application roles
        [Parameter(Position=2)]
        [switch]
        $ExpandApplicationRoles,

        # The JiraConnection object to use for the request
        [Parameter(Position=3)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/user"

        $expand = @()
        if($PSBoundParameters.ContainsKey("ExpandGroups")){$expand += "groups"}
        if($PSBoundParameters.ContainsKey("ExpandApplicationRoles")){$expand += "applicationRoles"}

        $body=@{
            accountId = $AccountId
        }
        if($expand.Length -gt 0){$body.Add("expand",$expand -join ",")}

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "GET" -Body $body
    }
}

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-user-groups-get

function Invoke-JiraGetUserGroups {
    [CmdletBinding()]
    param (
        # The accountID of the user to retrieve groups for
        [Parameter(Mandatory,Position=0)]
        [string]
        $AccountId,

        # The JiraConnection object to use for the request
        [Parameter(Position=1)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/user/groups"

        $body=@{accountId=$AccountId}

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "GET" -Body $body
    }
}

Export-ModuleMember -Function * -Variable *