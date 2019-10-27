class JiraDateTime {

    #####################
    # HIDDEN PROPERTIES #
    #####################

    

    #####################
    # PUBLIC PROPERTIES #
    #####################

    [datetime]
    $DateTime

    #####################
    # CONSTRUCTORS      #
    #####################

    JiraDateTime(){
        $this.DateTime = Get-Date
    }

    JiraDateTime(
        [datetime]$DateTime
    ){
        $this.DateTime = $DateTime
    }

    #####################
    # HIDDEN METHODS    #
    #####################

    

    #####################
    # PUBLIC METHODS    #
    #####################

    [datetime]
    SimpleFormat(){
        return $this.SimpleFormat($this.DateTime)
    }

    static
    [string]
    SimpleFormat(
        [datetime]$DateTime
    ){
        return Get-Date -Date $DateTime -Format "o"
    }

    [string]
    ComplexFormat(){
        return $this.ComplexFormat($this.DateTime)
    }

    static
    [string]
    ComplexFormat(
        [datetime]$DateTime
    ){
        return ((Get-Date -Date $DateTime -Format "o") -replace "(.*):(.*)", '$1$2') -replace "(.*)(\.[0-9]{3})([0-9]{4})(.*)", '$1$2$4'
    }
}