using module .\RestQueryKvp.psm1

class RestMethodQueryParams {
    
    #####################
    # HIDDEN PROPERTIES #
    #####################
    
    #####################
    # PUBLIC PROPERTIES #
    #####################

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
        foreach( $kv in $Params.GetEnumerator() | Sort-Object Name,Value) {
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
        $this.Params += New-Object RestQueryKvp @($Key, $Value)
    }
    
    [string]
    ToString(){
        $joined = ([RestQueryKvp]::JoinKvp($this.Params,'&','='))
        return '?' + $joined
    }
}