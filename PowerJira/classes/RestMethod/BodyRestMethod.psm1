using module ..\JiraContext.psm1
using module .\RestMethodQueryParams.psm1
using module .\RestMethod.psm1
using module .\RestMethodBody.psm1
using module .\RestMethodJsonBody.psm1

class BodyRestMethod : RestMethod {

    #####################
    # HIDDEN PROPERTIES #
    #####################
    
    #####################
    # PUBLIC PROPERTIES #
    #####################

    # Parameters to be supplied to the method in the body
    [RestMethodBody]
    $Body

    ################
    # CONSTRUCTORS #
    ################

    #body only
    BodyRestMethod(
        [string]$FunctionPath,
        [string]$HttpMethod,
        [RestMethodBody]$Body
    ) : base($FunctionPath,$HttpMethod) {
        $this.Body = $Body
    }

    #body + query
    BodyRestMethod(
        [string]$FunctionPath,
        [string]$HttpMethod,
        [RestMethodQueryParams]$Query,
        [RestMethodBody]$Body
    ) : base($FunctionPath,$HttpMethod,$Query) {
        $this.Body = $Body
    }

    ##################
    # HIDDEN METHODS #
    ##################

    

    ##################
    # PUBLIC METHODS #
    ##################

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
            Body = $this.Body.ToString()
        }
        return [RestMethod]::RootInvoke($invokeSplat)
    }
}