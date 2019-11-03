class HashtableUtility {

    #####################
    # HIDDEN PROPERTIES #
    #####################

    

    #####################
    # PUBLIC PROPERTIES #
    #####################

    

    #####################
    # CONSTRUCTORS      #
    #####################

    

    #####################
    # HIDDEN METHODS    #
    #####################

    

    #####################
    # PUBLIC METHODS    #
    #####################

    static
    [int32]
    FindDepth(
        [hashtable]$Hashtable
    ){
        return [HashtableUtility]::FindDepth($Hashtable,1)
    }

    static
    [int32]
    FindDepth(
        [hashtable]$Hashtable,
        [int32]$Depth
    ){
        $deepest = $Depth
        foreach($kv in $Hashtable.GetEnumerator()) {
            if($kv.Value -is [hashtable]) {
                $innerDepth = [HashtableUtility]::FindDepth($kv.Value,($Depth + 1))
                if ($innerDepth -gt $deepest) {$deepest = $innerDepth}
            } elseif ($kv.Value -is [system.array]) {
                $arrDepth = $Depth + 1
                if ($arrDepth -gt $deepest) {$deepest = $arrDepth}
                foreach($item in $kv.Value) {
                    if($item -is [hashtable]) {
                        $innerDepth = [HashtableUtility]::FindDepth($item,($arrDepth + 1))
                        if ($innerDepth -gt $deepest) {$deepest = $innerDepth}
                    }
                }
            }
        }
        return $deepest
    }

}