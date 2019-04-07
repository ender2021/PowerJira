#Adapted from: https://www.powershellgallery.com/packages/PSApigeeEdge/0.2.4/Content/Private%5CConvertFrom-HashtableToQueryString.ps1
function Format-HashtableToQueryString {
    <#
    .SYNOPSIS
      Convert a hashtable into a query string

    .DESCRIPTION
      Converts a hashtable into a query string by joining the keys to the values,
      and then joining all the pairs together

    .PARAMETER values
      The hashtable to convert

    .PARAMETER PairSeparator
      The string used to concatenate the sets of key=value pairs, defaults to "&"

    .PARAMETER KeyValueSeparator
      The string used to concatenate the keys to the values, defaults to "="

    .RETURNVALUE
      The query string created by joining keys to values and then joining
      them all together into a single string

    .EXAMPLE
           Format-HashtableToQueryString -Values @{
                name = 'abcdefg-1'
                apiProduct = 'Product1'
                keyExpiresIn = 86400000
            }
    #>

    param(
        # The values to format
        [Parameter(Mandatory,Position=0)]
        [hashtable]
        $Values,

        # The character to use to separate values (default is '&')
        [Parameter(Position=1)]
        [string]
        $PairSeparator = '&',

        # The value to use to separate key/value pairs
        [Parameter(Position=2)]
        [string]
        $KeyValueSeparator = '='
    )
    process {
        [string]::join($PairSeparator, @(
            foreach( $kv in $Values.GetEnumerator()) {
                if($kv.Name) {'{0}{1}{2}' -f $kv.Name, $KeyValueSeparator, $kv.Value}
            }
        ))
    }
}