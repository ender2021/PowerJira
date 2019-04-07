#NOTE: Multipart requests are only supported in PowerShell 6+
function Invoke-JiraRestRequest {
    [CmdletBinding(DefaultParameterSetName="JsonBody")]
    param (
        # The Jira Connection to use, if a session is not active.  The hashtable must have AuthHeader and HostName properties.
        [Parameter(Mandatory)]
        [AllowNull()]
        [hashtable]
        $JiraConnection,

        # The URI path of function to invoke (do not include host name)
        [Parameter(Mandatory)]
        [string]
        $FunctionPath,

        # The HTTP method to use for the request
        [Parameter(Mandatory)]
        [ValidateSet("GET","POST","PUT","PATCH","DELETE")]
        [string]
        $HttpMethod,

        # Addtional headers to be added to the request (Auth and Content Type are included automatically)
        [Parameter()]
        [hashtable]
        $Headers=@{},

        # The body of the request.  Will be serialized to json.
        [Parameter(ParameterSetName="JsonBody")]
        [hashtable]
        $Body,

        # Use to configure how deep the body hashtable is
        [Parameter(ParameterSetName="JsonBody")]
        [int32]
        $BodyDepth=4,

        # Allows passing a raw string for the body of the request
        [Parameter(ParameterSetName="SimpleBody")]
        [string]
        $LiteralBody,

        # Set this flag to send a multi-part request
        [Parameter(Mandatory,ParameterSetName="Multipart")]
        [switch]
        $Multipart,

        # The Form values for a multipart request
        [Parameter(Mandatory,ParameterSetName="Multipart")]
        [hashtable]
        $Form,

        # Used the same as the $Body param, but these parameters will be put into the query string
        [Parameter()]
        [ValidateNotNull()]
        [hashtable]
        $Query,

        # Query string key value pairs passed as an array of objects created by Format-QueryKvp
        [Parameter()]
        [object[]]
        $QueryKvp
    )
    process {
        if($null -eq $JiraConnection) { $JiraConnection = $Global:PowerJira.Session }
        if($null -eq $JiraConnection) {throw "No JiraConnection object provided, and no JiraSession open."}

        $sendHeaders = @{}
        $sendHeaders += $JiraConnection.AuthHeader
        $sendHeaders += $Headers
        
        #define uri
        $hostname = $JiraConnection.HostName
        $function = If($FunctionPath.StartsWith("/")) {$FunctionPath.Substring(1)} else {$FunctionPath}
        $uri = "$hostname/$function"
        if($PSBoundParameters.ContainsKey("Query") -and ($Query.Keys.Count -gt 0)){
            $uri += '?' + (Format-HashtableToQueryString $Query)
        } elseif ($PSBoundParameters.ContainsKey("QueryKvp") -and ($QueryKvp.Count -gt 0)) {
            $uri += '?' + (Format-KvpArrayToQueryString $QueryKvp)
        }

        if ($PSBoundParameters.ContainsKey("Multipart")) {
            $sendHeaders.Add("X-Atlassian-Token","no-check")
            Invoke-RestMethod -Uri $uri -Method $HttpMethod -Headers $sendHeaders -Form $Form
        } else {
            if (($null -ne $Body) -and ($Body.Count -gt 0) -and $HttpMethod -ne "DELETE") {
                $b = if(($HttpMethod -eq "GET")) {$Body} else {ConvertTo-Json $Body -Compress -Depth $BodyDepth}
                Invoke-RestMethod -Uri $uri -Method $HttpMethod -ContentType 'application/json' -Headers $sendHeaders -Body $b
            } elseif ($PSBoundParameters.ContainsKey("LiteralBody")) {
                if(($HttpMethod -eq "GET") -or ($HttpMethod -eq "DELETE")) {
                    $uri += '?' + $LiteralBody
                    Invoke-RestMethod -Uri $uri -Method $HttpMethod -ContentType 'application/json' -Headers $sendHeaders
                } else {
                    Invoke-RestMethod -Uri $uri -Method $HttpMethod -ContentType 'application/json' -Headers $sendHeaders -Body $LiteralBody
                }
            } else {
                if ($HttpMethod -eq "DELETE" -and ($null -ne $Body) -and ($Body.Count -gt 0)) {
                    $qs = Format-HashtableToQueryString $Body
                    $uri += '?' + $qs
                }
                Invoke-RestMethod -Uri $uri -Method $HttpMethod -ContentType 'application/json' -Headers $sendHeaders
            }
        }
    }
}