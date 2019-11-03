class RestMethodBody {
    
    #####################
    # HIDDEN PROPERTIES #
    #####################

    hidden
    [string]
    $BodyString
    
    #####################
    # PUBLIC PROPERTIES #
    #####################

    ################
    # CONSTRUCTORS #
    ################

    RestMethodBody(){
        $this.BodyString = ""
    }

    RestMethodBody(
        [string]$BodyString
    ) {
        $this.BodyString = $BodyString
    }

    ##################
    # HIDDEN METHODS #
    ##################

    ##################
    # PUBLIC METHODS #
    ##################

    [string]
    ToString()
    {
        return $this.BodyString
    }
}