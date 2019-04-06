$ValidProjectTypes = @("business", "ops", "service_desk", "software")
$ValidGetProjectsExpandTypes = @("description", "projectKeys", "lead", "issueTypes", "url")
#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-project-search-get
function Invoke-JiraGetProjects {
    [CmdletBinding()]
    param (
        # Filters the results using a case-insenstive match to project name and key
        [Parameter(Position=0)]
        [string]
        $Filter,

        # Use to filter projects by category
        [Parameter(Position=1)]
        [int64]
        $CategoryId,

        # The index of the first item to return in the page of results (page offset). The base index is 0.
        [Parameter(Position=2)]
        [int64]
        $StartAt=0,

        # The maximum number of items to return per page. The default is 50 and the maximum is 50.
        [Parameter(Position=3)]
        [ValidateRange(1,50)]
        [int32]
        $MaxResults=50,

        # Use this to order the results
        [Parameter(Position=4)]
        [ValidateSet("category","-category","+category","key","-key","+key",
                     "name", "-name", "+name", "owner", "-owner", "+owner")]
        [string]
        $OrderBy="key",

        # Project types to return
        [Parameter(Position=5)]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({Compare-StringArraySubset $ValidProjectTypes $_})]
        [string[]]
        $ProjectTypes = $ValidProjectTypes,

        # Use this to filter the results by the type of action the current user can perform
        [Parameter(Position=6)]
        [ValidateSet("view","browse","edit")]
        [string]
        $ActionFilter="view",

        # Result values to be expanded
        [Parameter(Position=7)]
        [ValidateScript({Compare-StringArraySubset $ValidGetProjectsExpandTypes $_})]
        [string[]]
        $Expand,

        # The JiraConnection object to use for the request
        [Parameter(Position=8)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/project/search"
        $verb = "GET"

        $query = @{}
        if($PSBoundParameters.ContainsKey("Expand")){$query.Add("expand",$Expand -join ",")}

        $body=@{
            startAt = $StartAt
            maxResults = $MaxResults
            orderBy = $OrderBy
            typeKey = $ProjectTypes -join ","
            action = $ActionFilter
        }
        if($PSBoundParameters.ContainsKey("Filter")){$body.Add("query",$Filter)}
        if($PSBoundParameters.ContainsKey("CategoryId")){$body.Add("categoryId",$CategoryId)}

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod $verb -Query $query -Body $body
    }
}