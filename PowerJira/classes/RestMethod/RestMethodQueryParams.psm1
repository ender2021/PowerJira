using module .\RestQueryKvp.psm1

class RestMethodQueryParams {
    
    #####################
    # HIDDEN PROPERTIES #
    #####################
    
    #####################
    # PUBLIC PROPERTIES #
    #####################

    [ValidateNotNullOrEmpty()]
    [RestQueryKvp[]]
    $Params

    ################
    # CONSTRUCTORS #
    ################

    RestMethodQueryParams(){
        $this.Params = @()
    }

    RestMethodQueryParams(
        [RestQueryKvp[]]$Params
    ){
        $this.Params = $Params
    }

    RestMethodQueryParams(
        [hashtable]$Params
    ){
        foreach( $kv in $Params.GetEnumerator()) {
            if($kv.Name) {$this.Add($kv.Name, $kv.Value)}
        }
    }

    ##################
    # HIDDEN METHODS #
    ##################

    ##################
    # PUBLIC METHODS #
    ##################

    [void]
    Add(
        [string]$Key,
        [object]$Value
    ){
        $this.Params += [RestQueryKvp]::new($Key, $Value)
    }
    
    [string]
    ToString(){
        return '?' + [RestQueryKvp]::JoinKvp($this.Params)
    }
}