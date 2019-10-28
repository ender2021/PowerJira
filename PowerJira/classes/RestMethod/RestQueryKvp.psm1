class RestQueryKvp {
    
    #####################
    # HIDDEN PROPERTIES #
    #####################
    
    #####################
    # PUBLIC PROPERTIES #
    #####################
    
    [ValidateNotNullOrEmpty()]
    [string]
    $Key

    [ValidateNotNull()]
    [string]
    $Value

    ################
    # CONSTRUCTORS #
    ################

    RestQueryKvp(
        [string]$Key,
        [object]$Value
    ){
        $this.Key = $Key
        $this.Value = $Value.ToString()
    }

    ##################
    # HIDDEN METHODS #
    ##################

    ##################
    # PUBLIC METHODS #
    ##################

    [bool]
    Equals(
        [object]$obj
    ){
        return $obj.Key -eq $this.Key -and $obj.Value -eq $this.Value
    }

    #Adapted from: https://www.powershellgallery.com/packages/PSApigeeEdge/0.2.4/Content/Private%5CConvertFrom-HashtableToQueryString.ps1
    static
    [string]
    JoinKvp(
        # The values to format
        [RestQueryKvp[]]
        $Values,

        # The character to use to separate values (default is '&')
        [string]
        $PairSeparator = '&',

        # The value to use to separate key/value pairs
        [string]
        $KeyValueSeparator = '='
    ){
        return [string]::join($PairSeparator, @(
            foreach( $kv in $Values) {
                if($kv.Key) {
                    '{0}{1}{2}' -f $kv.Key, $KeyValueSeparator, $kv.Value
                }
            }
        ))
    }
}