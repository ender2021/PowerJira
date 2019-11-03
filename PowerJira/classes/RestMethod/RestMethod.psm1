using module ..\JiraContext.psm1
using module .\RestMethodQueryParams.psm1

class RestMethod {

    #####################
    # HIDDEN PROPERTIES #
    #####################
    
    #####################
    # PUBLIC PROPERTIES #
    #####################

    # The URI path of function to invoke (do not include host name)
    [ValidateNotNullOrEmpty()]
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
    RestMethod(
        [string]$FunctionPath,
        [string]$HttpMethod
    ){
        $this.Init($FunctionPath,$HttpMethod)
    }

    #query params only
    RestMethod(
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

    hidden
    [void]
    Init(
        [string]$FunctionPath,
        [string]$HttpMethod
    ){
        $this.FunctionPath = if ($FunctionPath.StartsWith("/")) {$FunctionPath.Substring(1)} else {$FunctionPath}
        $this.HttpMethod = $HttpMethod
    }

    hidden
    static
    [JiraContext]
    FillContext(
        [JiraContext]$JiraContext
    ){
        if ($null -eq $JiraContext) {
            $toReturn = $Global:PowerJira.Context
            if ($null -eq $toReturn) {
                throw "`$JiraContext was not provided when invoking a REST method"
            } else {
                return $toReturn
            }
        } else {
            return $JiraContext
        }
    }

    ##################
    # PUBLIC METHODS #
    ##################

    [string]
    Uri(
        [JiraContext]$JiraContext
    ){
        $uri = $JiraContext.HostName + "/" + $this.FunctionPath
        if ($this.Query -and $this.Query.Params -and $this.Query.Params.Count -gt 0) {
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
    Invoke(){
        return $this.Invoke($Global:PowerJira.Context)
    }

    [object]
    Invoke(
        [JiraContext]$JiraContext
    ){
        $JiraContext = [RestMethod]::FillContext($JiraContext)
        $invokeSplat = @{
            Uri = $this.Uri($JiraContext)
            Method = $this.HttpMethod
            ContentType = $this.ContentType 
            Headers = $this.HeadersToSend($JiraContext) 
            MaximumRetryCount = $JiraContext.Retries
            RetryIntervalSec = $JiraContext.RetryDelay
        }
        return Invoke-RestMethod @invokeSplat
    }
}