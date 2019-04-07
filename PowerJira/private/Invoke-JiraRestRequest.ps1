#NOTE: Multipart requests are only supported in PowerShell 6+
function Invoke-JiraRestRequest {
    [CmdletBinding(DefaultParameterSetName="NoBody-HashQuery")]
    param (
        # The Jira Connection to use, if a session is not active.  The hashtable must have AuthHeader and HostName properties.
        [Parameter(Mandatory,Position=0)]
        [AllowNull()]
        [hashtable]
        $JiraConnection,

        # The URI path of function to invoke (do not include host name)
        [Parameter(Mandatory,Position=1)]
        [string]
        $FunctionPath,

        # The HTTP method to use for the request
        [Parameter(Mandatory,Position=2)]
        [ValidateSet("GET","POST","PUT","PATCH","DELETE")]
        [string]
        $HttpMethod,

        # Addtional headers to be added to the request (Auth and Content Type are included automatically)
        [Parameter(Position=3)]
        [hashtable]
        $Headers=@{},
        
        # Used the same as the $Body param, but these parameters will be put into the query string
        [Parameter(ParameterSetName="NoBody-HashQuery",Position=4)]
        [Parameter(Mandatory,ParameterSetName="JsonBody-HashQuery",Position=4)]
        [Parameter(Mandatory,ParameterSetName="SimpleBody-HashQuery",Position=4)]
        [ValidateNotNull()]
        [hashtable]
        $Query,

        # Query string key value pairs passed as an array of objects created by Format-QueryKvp
        [Parameter(Mandatory,ParameterSetName="NoBody-ArrayQuery",Position=4)]
        [Parameter(Mandatory,ParameterSetName="JsonBody-ArrayQuery",Position=4)]
        [Parameter(Mandatory,ParameterSetName="SimpleBody-ArrayQuery",Position=4)]
        [ValidateNotNull()]
        [object[]]
        $QueryKvp,

        # The body of the request.  Will be serialized to json.
        [Parameter(Mandatory,ParameterSetName="JsonBody",Position=4)]
        [Parameter(Mandatory,ParameterSetName="JsonBody-HashQuery",Position=5)]
        [Parameter(Mandatory,ParameterSetName="JsonBody-ArrayQuery",Position=5)]
        [ValidateNotNull()]
        [hashtable]
        $Body,

        # Use to configure how deep the body hashtable is
        [Parameter(ParameterSetName="JsonBody",Position=5)]
        [Parameter(ParameterSetName="JsonBody-HashQuery",Position=6)]
        [Parameter(ParameterSetName="JsonBody-ArrayQuery",Position=6)]
        [int32]
        $BodyDepth=4,

        # Allows passing a raw string for the body of the request
        [Parameter(Mandatory,ParameterSetName="SimpleBody",Position=4)]
        [Parameter(Mandatory,ParameterSetName="SimpleBody-HashQuery",Position=5)]
        [Parameter(Mandatory,ParameterSetName="SimpleBody-ArrayQuery",Position=5)]
        [ValidateNotNullOrEmpty()]
        [string]
        $LiteralBody,

        # The Form values for a multipart request
        [Parameter(Mandatory,ParameterSetName="Multipart",Position=4)]
        [ValidateNotNull()]
        [hashtable]
        $Form
    )
    process {
        if($null -eq $JiraConnection) { $JiraConnection = $Global:PowerJira.Session }
        if($null -eq $JiraConnection) {throw "No JiraConnection object provided, and no JiraSession open."}

        $sendHeaders = @{}
        $sendHeaders += $JiraConnection.AuthHeader
        $sendHeaders += $Headers

        $contentType = 'application/json'
        
        #define uri
        $hostname = $JiraConnection.HostName
        $function = If($FunctionPath.StartsWith("/")) {$FunctionPath.Substring(1)} else {$FunctionPath}
        $uri = "$hostname/$function"
        if($PSBoundParameters.ContainsKey("Query") -and ($Query.Keys.Count -gt 0)){
            $uri += '?' + (Format-HashtableToQueryString $Query)
        } elseif ($PSBoundParameters.ContainsKey("QueryKvp") -and ($QueryKvp.Count -gt 0)) {
            $uri += '?' + (Format-KvpArrayToQueryString $QueryKvp)
        }

        switch ($PSCmdlet.ParameterSetName) {
            {($_ -match "NoBody") -or (($_ -match "JsonBody") -and ($Body.Count -eq 0))} { 
                Invoke-RestMethod -Uri $uri -Method $HttpMethod -ContentType $contentType -Headers $sendHeaders                
             }
            {$_ -match "JsonBody"} { 
                $bodyJson = ConvertTo-Json $Body -Compress -Depth $BodyDepth
                Invoke-RestMethod -Uri $uri -Method $HttpMethod -ContentType $contentType -Headers $sendHeaders -Body $bodyJson
             }
            {$_ -match "SimpleBody"} { 
                Invoke-RestMethod -Uri $uri -Method $HttpMethod -ContentType $contentType -Headers $sendHeaders -Body $LiteralBody
             }
            {$_ -match "Multipart"} { 
                $sendHeaders.Add("X-Atlassian-Token","no-check")
                Invoke-RestMethod -Uri $uri -Method $HttpMethod -Headers $sendHeaders -Form $Form
             }
            Default {
                ThrowError "Parameter set not found" "Unknown parameter set '$_' in Invoke-JiraRestRequest"
            }
        }
    }
}