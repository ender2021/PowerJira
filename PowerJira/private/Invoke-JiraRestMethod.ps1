#NOTE: Multipart requests are only supported in PowerShell 6+
function Invoke-JiraRestMethod {
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
        [Parameter(ParameterSetName="Multipart",Position=4)]
        [Parameter(ParameterSetName="File",Position=4)]
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
     
        # Allows passing a raw string for the body of the request
        [Parameter(Mandatory,ParameterSetName="SimpleBody",Position=4)]
        [Parameter(Mandatory,ParameterSetName="SimpleBody-HashQuery",Position=5)]
        [Parameter(Mandatory,ParameterSetName="SimpleBody-ArrayQuery",Position=5)]
        [AllowEmptyString()]
        [string]
        $LiteralBody,

        # The Form values for a multipart request
        [Parameter(Mandatory,ParameterSetName="Multipart",Position=5)]
        [ValidateNotNull()]
        [hashtable]
        $Form,

        # The file object, when POST-ing or PUT-ing a file
        [Parameter(Mandatory,ParameterSetName="File",Position=5)]
        [object]
        $File
    )
    process {
        #validate $JiraConnection
        if($null -eq $JiraConnection) { $JiraConnection = $Global:PowerJira.Session }
        if($null -eq $JiraConnection) {throw "Missing/Malformed JiraConnection: No JiraConnection object provided, and no JiraSession open."}
        if(!($JiraConnection.ContainsKey("AuthHeader") -and $JiraConnection.ContainsKey("HostName"))) {throw "Missing/Malformed JiraConnection: The provided object is missing one of the required properties (AuthHeader and HostName)."}

        #validate method / body combination
        if ((@("GET","DELETE") -contains $HttpMethod) -and !($PSCmdlet.ParameterSetName -match "NoBody")) {
            throw "Invalid HttpMethod / Parameter combination: Cannot use HttpMethod '$HttpMethod' with -Body, -LiteralBody, or -Form"
        }

        #compile headers object
        $sendHeaders = @{}
        $sendHeaders += $JiraConnection.AuthHeader
        $sendHeaders += $Headers

        #set the default content type
        $contentType = 'application/json'
        
        #define uri
        $hostname = if($JiraConnection.HostName.EndsWith("/")) { $JiraConnection.HostName.Substring(0, ($JiraConnection.HostName.Length - 1))} else {$JiraConnection.HostName}
        $function = If($FunctionPath.StartsWith("/")) {$FunctionPath.Substring(1)} else {$FunctionPath}
        $uri = "$hostname/$function"
        if($PSBoundParameters.ContainsKey("Query") -and ($Query.Keys.Count -gt 0)){
            $uri += '?' + (Format-HashtableToQueryString $Query)
        } elseif ($PSBoundParameters.ContainsKey("QueryKvp") -and ($QueryKvp.Count -gt 0)) {
            $uri += '?' + (Format-KvpArrayToQueryString $QueryKvp)
        }

        $restSplat = @{
            Uri = $uri
            Method = $HttpMethod
            Headers = $sendHeaders
            RetryIntervalSec = $JiraConnection.Retry.Delay
            MaximumRetryCount = $JiraConnection.Retry.Max
        }
        #select correct invocation depending on parameters provided
        switch ($PSCmdlet.ParameterSetName) {
            {($_ -match "NoBody") -or (($_ -match "JsonBody") -and ($Body.Count -eq 0))} {
                $restSplat.Add("ContentType", $contentType)
             }
            {$_ -match "JsonBody"} {
                $bodyDepth = Find-HashtableDepth $Body
                $bodyJson = ConvertTo-Json $Body -Compress -Depth $bodyDepth
                $restSplat.Add("ContentType", $contentType)
                $restSplat.Add("Body", $bodyJson)
             }
            {$_ -match "SimpleBody"} { 
                $restSplat.Add("ContentType", $contentType)
                $restSplat.Add("Body", $LiteralBody)
             }
            {$_ -match "Multipart"} { 
                $restSplat.Headers.Add("X-Atlassian-Token","no-check")
                $restSplat.Add("Form", $Form)
             }
             {$_ -match "File"} { 
                $restSplat.Headers.Add("X-Atlassian-Token","no-check")
                $restSplat.Add("InFile", $File)
             }
            Default {
                throw "Invalid Parameter Set: Unknown parameter set '$_' in Invoke-JiraRestMethod"
            }
        }
        Invoke-RestMethod @restSplat
    }
}