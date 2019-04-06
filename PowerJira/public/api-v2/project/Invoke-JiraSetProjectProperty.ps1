#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-project-projectIdOrKey-properties-propertyKey-put
function Invoke-JiraSetProjectProperty {
    [CmdletBinding()]
    param (
        # The project Id or Key
        [Parameter(Mandatory,Position=0)]
        [string]
        $ProjectIdOrKey,

        # The key of the property to set
        [Parameter(Mandatory,Position=1)]
        [string]
        $PropertyKey,

        # Supply any hashtable that can be converted to valid JSON.  The maximum serialized length is 32768 characters.
        [Parameter(Mandatory,Position=2)]
        [ValidateScript({ (ConvertTo-Json $_).Length -lt 32769 })]
        [hashtable]
        $Value,
       
        # The JiraConnection object to use for the request
        [Parameter(Position=3)]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/project/$ProjectIdOrKey/properties/$PropertyKey"

        $body=$Value

        Invoke-JiraRestRequest -JiraConnection $JiraConnection -FunctionPath $functionPath -HttpMethod "PUT" -Body $body
    }
}