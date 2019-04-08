function Find-HashtableDepth {
    [CmdletBinding()]
    param (
        # The input hashtable
        [Parameter(Mandatory,Position=0)]
        [hashtable]
        $Hashtable,

        # The current depth of the hashtable
        [Parameter(Position=1)]
        [int32]
        $Depth=0
    )
    process {
        $deepest = $Depth
        foreach($kv in $Hashtable.GetEnumerator()) {
            if($kv.Value -is [hashtable]) {
                $innerDepth = Find-HashtableDepth $kv.Value ($Depth + 1)
                if ($innerDepth -gt $deepest) {$deepest = $innerDepth}
            } elseif ($kv.Value -is [system.array]) {
                $arrDepth = $Depth + 1
                if ($arrDepth -gt $deepest) {$deepest = $arrDepth}
                foreach($item in $kv.Value) {
                    if($item -is [hashtable]) {
                        $innerDepth = Find-HashtableDepth $item ($arrDepth + 1)
                        if ($innerDepth -gt $deepest) {$deepest = $innerDepth}
                    }
                }
            }
        }
        $deepest
    }
}