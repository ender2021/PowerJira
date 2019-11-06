using module ..\JiraContext.psm1
using module .\RestMethodQueryParams.psm1
using module .\RestMethod.psm1

class FileRestMethod : RestMethod {

    #####################
    # HIDDEN PROPERTIES #
    #####################
    
    #####################
    # PUBLIC PROPERTIES #
    #####################

    # The path to the file, when POST-ing or PUT-ing a file
    [string]
    $FilePath

    ################
    # CONSTRUCTORS #
    ################

    #file only
    FileRestMethod(
        [string]$FunctionPath,
        [string]$HttpMethod,
        [string]$FilePath
    ) : base($FunctionPath,$HttpMethod) {
        $this.FileInit($FilePath)
    }

    #file + query
    FileRestMethod(
        [string]$FunctionPath,
        [string]$HttpMethod,
        [RestMethodQueryParams]$Query,
        [string]$FilePath
    ) : base($FunctionPath,$HttpMethod,$Query) {
        $this.FileInit($FilePath)
    }

    ##################
    # HIDDEN METHODS #
    ##################

    hidden
    [void]
    FileInit([string]$FilePath){
        $this.FilePath = $FilePath
        if(!$this.Headers.ContainsKey("X-Atlassian-Token")) {
            $this.Headers.Add("X-Atlassian-Token","no-check")
        }
    }

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
            Headers = $this.HeadersToSend($JiraContext) 
            MaximumRetryCount = $JiraContext.Retries
            RetryIntervalSec = $JiraContext.RetryDelay
            InFile = $this.FilePath
        }
        return [RestMethod]::RootInvoke($invokeSplat)
    }
}