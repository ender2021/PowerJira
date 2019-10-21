using module ..\JiraContext.psm1
using module .\RestMethodQueryParams.psm1
using module .\RestMethod.psm1

class FormRestMethod : RestMethod {

    #####################
    # HIDDEN PROPERTIES #
    #####################
    
    #####################
    # PUBLIC PROPERTIES #
    #####################

    # Form values for a multipart request
    [hashtable]
    $Form

    ################
    # CONSTRUCTORS #
    ################

    #form only
    FormRestMethod(
        [string]$FunctionPath,
        [string]$HttpMethod,
        [hashtable]$Form
    ) : base($FunctionPath,$HttpMethod) {
        $this.FormInit($Form)
    }

    #form + query
    FormRestMethod(
        [string]$FunctionPath,
        [string]$HttpMethod,
        [RestMethodQueryParams]$Query,
        [hashtable]$Form
    ) : base($FunctionPath,$HttpMethod,$Query) {
        $this.FormInit($Form)
    }

    ##################
    # HIDDEN METHODS #
    ##################

    hidden
    [void]
    FormInit([hashtable]$Form){
        $this.Form = $Form
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
        $JiraContext = $this.FillJiraContext($JiraContext)
        $invokeSplat = @{
            Uri = $this.Uri($JiraContext)
            Method = $this.HttpMethod
            Headers = $this.HeadersToSend($JiraContext) 
            Form = $this.Form
        }
        return Invoke-RestMethod @invokeSplat
    }
}