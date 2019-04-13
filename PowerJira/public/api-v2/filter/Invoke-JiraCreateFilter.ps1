$JiraFilterExpand = @("sharedUsers","subscriptions")

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-filter-post
function Invoke-JiraCreateFilter {
    [CmdletBinding()]
    param (
        # The name to give the filter. Must be unique.
        [Parameter(Mandatory,Position=0)]
        [string]
        $Name,

        # The JQL to define for the filter
        [Parameter(Mandatory,Position=1)]
        [string]
        $Jql,

        # A description for the filter
        [Parameter(Position=2)]
        [string]
        $Description,

        # Used to expand additional attributes
        [Parameter(Position=3)]
        [ValidateScript({ Compare-StringArraySubset $JiraFilterExpand $_ })]
        [string[]]
        $Expand,

        # Set this value to 1 or greater to return more than 1000 users when expanding sharedUsers
        [Parameter(Position=4)]
        [int32]
        $SharedUsersPage,

        # Set this value to 1 or greater to return more than 1000 users when expanding subscriptions
        [Parameter(Position=5)]
        [int32]
        $SubscriptionsPage,

        # Set this flag to indicate that the filter should be added to the users favourites
        [Parameter()]
        [switch]
        $Favourite,

        # The JiraConnection object to use for the request
        [Parameter()]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/filter"
        $verb = "POST"

        $query=@{}
        if($PSBoundParameters.ContainsKey("Expand")){
            if ($Expand.Contains("sharedUsers") -and $PSBoundParameters.ContainsKey("SharedUsersPage")) {
                $usi = (1000 * $SharedUsersPage) + 1
                $uei = $usi + 1000
                $Expand.Remove("sharedUsers")
                $Expand.Add("sharedUsers[$usi" + ':' + "$uei]")
            }
            if ($Expand.Contains("subscriptions") -and $PSBoundParameters.ContainsKey("SubscriptionsPage")) {
                $ssi = (1000 * $SubscriptionsPage) + 1
                $sei = $ssi + 1000
                $Expand.Remove("subscriptions")
                $Expand.Add("subscriptions[$ssi" + ':' + "$sei]")
            }
            $query.Add("expand",$Expand -join ",")
        }

        $body=@{
            name = $Name
            jql = $Jql
            favourite = $false
        }
        if($PSBoundParameters.ContainsKey("Description")){$body.Add("description",$Description)}
        if($PSBoundParameters.ContainsKey("Favourite")){$body.favourite = $true}

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Query $query -Body $body
    }
}