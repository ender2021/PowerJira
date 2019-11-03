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

    static
    [pscustomobject]
    NewCompareResult(
        [object]$Key,
        [object]$LValue,
        [object]$Side,
        [object]$RValue
    ){
        return New-Object -Type PSObject -Property @{
            key    = $Key
            lvalue = $LValue
            rvalue = $RValue
            side   = $Side
        }
    }

    #####################
    # PUBLIC METHODS    #
    #####################

<#
.SYNOPSIS
Compare two Hashtable and returns an array of differences.

.DESCRIPTION
The Compare function computes differences between two Hashtables. Results are returned as
an array of objects with the properties: "key" (the name of the key that caused a difference), 
"side" (one of "<=", "!=" or "=>"), "lvalue" an "rvalue" (resp. the left and right value 
associated with the key).

Adapted from #https://gist.github.com/dbroeglin/c6ce3e4639979fa250cf#file-compare-hashtable-ps1

.PARAMETER left 
The left hand side Hashtable to compare.

.PARAMETER right 
The right hand side Hashtable to compare.

.EXAMPLE

Returns a difference for ("3 <="), c (3 "!=" 4) and e ("=>" 5).

[HashtableUtility]::Compare(@{ a = 1; b = 2; c = 3 },@{ b = 2; c = 4; e = 5})

.EXAMPLE 

Returns a difference for a ("3 <="), c (3 "!=" 4), e ("=>" 5) and g (6 "<=").

$left = @{ b = 2; c = 4; e = 5; f = $Null; g = $Null }
$right = @{ b = 2; c = 4; e = 5; f = $Null; g = $Null }

[HashtableUtility]::Compare($left,$right)

#>	
    static
    [object[]]
    Compare(
        [hashtable]$Left,
        [hashtable]$Right
    ){
        
        [Object[]]$Results = $Left.Keys | % {
            if ($Left.ContainsKey($_) -and !$Right.ContainsKey($_)) {
                [HashtableUtility]::NewCompareResult($_,$Left[$_],"<=",$Null)
            } else {
                $LValue, $RValue = $Left[$_], $Right[$_]
                if ($LValue -ne $RValue) {
                    [HashtableUtility]::NewCompareResult($_,$LValue,"!=",$RValue)
                }
            }
        }
        $Results += $Right.Keys | % {
            if (!$Left.ContainsKey($_) -and $Right.ContainsKey($_)) {
                [HashtableUtility]::NewCompareResult($_,$Null,"=>",$Right[$_])
            } 
        }
        return $Results
    }

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