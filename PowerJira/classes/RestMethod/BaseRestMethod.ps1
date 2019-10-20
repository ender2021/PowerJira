class BaseRestMethod {

    #####################
    # HIDDEN PROPERTIES #
    #####################
    
    #####################
    # PUBLIC PROPERTIES #
    #####################

    # The URI path of function to invoke (do not include host name)
    [string]
    $FunctionPath

    # The HTTP method to use for the request
    [ValidateSet("GET","POST","PUT","PATCH","DELETE")]
    [string]
    $HttpMethod

    # Additional headers to be added to the request (Auth and Content Type are included automatically)
    [hashtable]
    $Headers=@{}

    # The default content type
    [string]
    $ContentType = 'application/json'

    # Parameters to be supplied to the method in the query string
    [RestMethodQueryParams]
    $Query

    ################
    # CONSTRUCTORS #
    ################

    #no params
    RestMethodInput(
        [string]$FunctionPath,
        [string]$HttpMethod
    ){
        $this.Init($FunctionPath,$HttpMethod)
    }

    #query params only
    RestMethodInput(
        [string]$FunctionPath,
        [string]$HttpMethod,
        [RestMethodQueryParams]$Query
    ){
        $this.Init($FunctionPath,$HttpMethod)
        $this.Query = $Query
    }

    ##################
    # HIDDEN METHODS #
    ##################

    hidden Init(
        [string]$FunctionPath,
        [string]$HttpMethod
    ){
        $this.FunctionPath = $FunctionPath
        $this.HttpMethod = $HttpMethod
    }

    ##################
    # PUBLIC METHODS #
    ##################

    [string]
    Uri(
        [JiraContext]$JiraContext
    ){
        $uri = $JiraContext.HostName + "/" + $this.FunctionPath
        if ($this.Query -and $this.Query.Values.Count -gt 0) {
            $uri += $this.Query.ToString()
        }
        return $uri
    }

    [hashtable]
    HeadersToSend(
        [JiraContext]$JiraContext
    ){
        #compile headers object
        $sendHeaders = @{}
        $sendHeaders += $JiraContext.AuthHeader
        $sendHeaders += $this.Headers
        return $sendHeaders
    }

    [object]
    Invoke(
        [JiraContext]$JiraContext
    ){
        $invokeSplat = @{
            Uri = $this.Uri($JiraContext)
            Method = $this.HttpMethod
            ContentType = $this.ContentType 
            Headers = $this.HeadersToSend($JiraContext) 
        }
        return Invoke-RestMethod @invokeSplat
    }
}