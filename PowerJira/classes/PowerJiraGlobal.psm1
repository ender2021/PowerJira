using module .\JiraContext.psm1

class PowerJiraGlobal {

    #####################
    # HIDDEN PROPERTIES #
    #####################

    

    #####################
    # PUBLIC PROPERTIES #
    #####################

    [JiraContext]
    $Context=$null

    #####################
    # CONSTRUCTORS      #
    #####################

    

    #####################
    # HIDDEN METHODS    #
    #####################

    

    #####################
    # PUBLIC METHODS    #
    #####################

    [void]
    OpenSession(
        [JiraContext]$JiraContext
    ){
        $this.Context = $JiraContext
    }

    [void]
    CloseSession(){
        $this.Context = $null
    }

}