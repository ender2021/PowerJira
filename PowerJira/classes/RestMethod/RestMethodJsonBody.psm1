using module .\RestMethodBody.psm1

class RestMethodJsonBody : RestMethodBody {
    
    #####################
    # HIDDEN PROPERTIES #
    #####################
    
    #####################
    # PUBLIC PROPERTIES #
    #####################

    [hashtable]
    $Values = @{}

    ################
    # CONSTRUCTORS #
    ################

    RestMethodJsonBody(){}

    RestMethodJsonBody(
        [hashtable]$Values
    ){
        $this.Values = $Values
    }

    ##################
    # HIDDEN METHODS #
    ##################

    ##################
    # PUBLIC METHODS #
    ##################

    [string]
    ToString(){
        return ConvertTo-Json $this.Values -Compress -Depth (Find-HashtableDepth $this.Values)
    }

    [void]
    Add(
        [string]$Key,
        [object]$Value
    ){
        $this.Values.Add($Key, $Value)
    }
}