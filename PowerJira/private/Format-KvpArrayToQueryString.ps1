#Adapted from: https://www.powershellgallery.com/packages/PSApigeeEdge/0.2.4/Content/Private%5CConvertFrom-HashtableToQueryString.ps1
function Format-KvpArrayToQueryString {
    <#
    .SYNOPSIS
      Convert an array of objects with the properties "key" and "value" into a query string

    .DESCRIPTION
      Converts an array of objects with the properties "key" and "value" into a query string
      by joining the keys to the values, and then joining all the pairs together

    .PARAMETER values
      The array to convert

    .PARAMETER PairSeparator
      The string used to concatenate the sets of key=value pairs, defaults to "&"

    .PARAMETER KeyValueSeparator
      The string used to concatenate the keys to the values, defaults to "="

    .RETURNVALUE
      The query string created by joining keys to values and then joining
      them all together into a single string

    .EXAMPLE
           Format-KvpArrayToQueryString -Values @(
                @{key="name";value='abcdefg-1'},
                @{key="apiProduct";value='Product1'},
                @{key="keyExpiresIn";value=86400000}
            )
    #>

    param(
        # The values to format
        [Parameter(Mandatory)]
        [object[]]
        $Values,

        # The character to use to separate values (default is '&')
        [Parameter()]
        [string]
        $PairSeparator = '&',

        # The value to use to separate key/value pairs
        [Parameter()]
        [string]
        $KeyValueSeparator = '=',

        # Use to sort the outcome
        [Parameter()]
        [string[]]
        $Sort
    )
    process {
        [string]::join($PairSeparator, @(
            if($Sort) {
                foreach( $kv in $Values | Sort-Object $Sort) {
                    if($kv.key) {
                    '{0}{1}{2}' -f $kv.key, $KeyValueSeparator, $kv.value
                    }
                }
            } else {
                foreach( $kv in $Values) {
                    if($kv.key) {
                    '{0}{1}{2}' -f $kv.key, $KeyValueSeparator, $kv.value
                    }
                }
            }
        ))
    }
}