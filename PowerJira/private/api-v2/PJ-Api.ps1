function Format-JiraRestDateTime {
    [CmdletBinding()]
    param (
        # The DateTime to format
        [Parameter(Mandatory=$true)]
        [datetime]
        $DateTime
    )
    process {
        ((Get-Date -Date $DateTime -Format "o") -replace "(.*):(.*)", '$1$2') -replace "(.*)(\.[0-9]{3})([0-9]{4})(.*)", '$1$2$4'
    }
}

function Test-Id {
    param (
        # The value to be tested
        [Parameter(Mandatory)]
        [string]
        $Value
    )
    process {
        $Value -match "^[\d\.]+$"
    }
}

#NOTE: Multipart requests are only supported in PowerShell 6+
function Invoke-JiraRestRequest {
    [CmdletBinding(DefaultParameterSetName="JsonBody")]
    param (
        # The Jira Connection to use, if a session is not active.  The hashtable must have AuthHeader and HostName properties.
        [Parameter(Mandatory)]
        [AllowNull()]
        [hashtable]
        $JiraConnection,

        # The URI path of function to invoke (do not include host name)
        [Parameter(Mandatory)]
        [string]
        $FunctionPath,

        # The HTTP method to use for the request
        [Parameter(Mandatory)]
        [ValidateSet("GET","POST","PUT","PATCH","DELETE")]
        [string]
        $HttpMethod,

        # Addtional headers to be added to the request (Auth and Content Type are included automatically)
        [Parameter()]
        [hashtable]
        $Headers=@{},

        # The body of the request.  Will be serialized to json.
        [Parameter(ParameterSetName="JsonBody")]
        [hashtable]
        $Body,

        # Use to configure how deep the body hashtable is
        [Parameter(ParameterSetName="JsonBody")]
        [int32]
        $BodyDepth=4,

        # Allows passing a raw string for the body of the request
        [Parameter(ParameterSetName="SimpleBody")]
        [string]
        $LiteralBody,

        # Set this flag to send a multi-part request
        [Parameter(Mandatory,ParameterSetName="Multipart")]
        [switch]
        $Multipart,

        # The Form values for a multipart request
        [Parameter(Mandatory,ParameterSetName="Multipart")]
        [hashtable]
        $Form
    )
    process {
        if($null -eq $JiraConnection) { $JiraConnection = $Global:PJ_JiraSession }
        if($null -eq $JiraConnection) {throw "No JiraConnection object provided, and no JiraSession open."}

        $sendHeaders = @{}
        $sendHeaders += $JiraConnection.AuthHeader
        $sendHeaders += $Headers
        
        #define uri
        $hostname = $JiraConnection.HostName
        $function = If($FunctionPath.StartsWith("/")) {$FunctionPath.Substring(1)} else {$FunctionPath}
        $uri = "$hostname/$function"

        if ($PSBoundParameters.ContainsKey("Multipart")) {
            $sendHeaders.Add("X-Atlassian-Token","no-check")
            Invoke-RestMethod -Uri $uri -Method $HttpMethod -Headers $sendHeaders -Form $Form
        } else {
            if (($null -ne $Body) -and ($Body.Count -gt 0) -and $HttpMethod -ne "DELETE") {
                $b = if(($HttpMethod -eq "GET")) {$Body} else {ConvertTo-Json $Body -Compress -Depth $BodyDepth}
                Invoke-RestMethod -Uri $uri -Method $HttpMethod -ContentType 'application/json' -Headers $sendHeaders -Body $b
            } elseif ($PSBoundParameters.ContainsKey("LiteralBody")) {
                if(($HttpMethod -eq "GET") -or ($HttpMethod -eq "DELETE")) {
                    $uri += '?' + $LiteralBody
                    Invoke-RestMethod -Uri $uri -Method $HttpMethod -ContentType 'application/json' -Headers $sendHeaders
                } else {
                    Invoke-RestMethod -Uri $uri -Method $HttpMethod -ContentType 'application/json' -Headers $sendHeaders -Body $LiteralBody
                }
            } else {
                if ($HttpMethod -eq "DELETE" -and ($null -ne $Body) -and ($Body.Count -gt 0)) {
                    $qs = Format-HashtableToQueryString $Body
                    $uri += '?' + $qs
                }
                Invoke-RestMethod -Uri $uri -Method $HttpMethod -ContentType 'application/json' -Headers $sendHeaders
            }
        }
    }
}

function New-JiraConnection {
    [CmdletBinding(DefaultParameterSetName="PlainText")]
    param (
        # The Jira username of the user performing actions
        [Parameter(Mandatory=$true,ParameterSetName="PlainText")]
        [string]
        $UserName,

        # The Jira password (or API Token) of the user performing actions
        [Parameter(Mandatory=$true,ParameterSetName="PlainText")]
        [string]
        $Password,

        # The hostname of the Jira instance to interact with (e.g. https://yourjirasite.atlassian.net/)
        [Parameter(Mandatory=$true)]
        [string]
        $HostName
    )
    # create the unencoded string
    $credentialsText = "$UserName`:$Password"

    # encode the string in base64
    $credentialsBytes = [System.Text.Encoding]::UTF8.GetBytes($credentialsText)
    $encodedCredentials = [Convert]::ToBase64String($credentialsBytes)

    # format the host name
    $formattedHost = (&{If($HostName.EndsWith("/")) {$HostName.Substring(0,$HostName.Length-1)} else {$HostName}})

    @{
        AuthHeader = @{Authorization="Basic $encodedCredentials"}
        HostName = $formattedHost
    }    
}

function Open-JiraSession {
    [CmdletBinding(DefaultParameterSetName="PlainText")]
    param (
        # The Jira username of the user performing actions
        [Parameter(Mandatory=$true,ParameterSetName="PlainText")]
        [string]
        $UserName,

        # The Jira password (or API Token) of the user performing actions
        [Parameter(Mandatory=$true,ParameterSetName="PlainText")]
        [string]
        $Password,

        # The hostname of the Jira instance to interact with (e.g. https://yourjirasite.atlassian.net/)
        [Parameter(Mandatory=$true)]
        [string]
        $HostName
    )
    process {
        $Global:PJ_JiraSession = New-JiraConnection -UserName $UserName -Password $Password -HostName $HostName
    }
}

function Close-JiraSession() {
    process {
        Remove-Variable PJ_JiraSession -Scope Global
    }
}

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
        [Parameter(Mandatory)]
        [hashtable]
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
                foreach( $kv in $Values.GetEnumerator() | Sort $Sort) {
                    if($kv.Name) {
                    '{0}{1}{2}' -f $kv.Name, $KeyValueSeparator, $kv.Value
                    }
                }
            } else {
                foreach( $kv in $Values.GetEnumerator()) {
                    if($kv.Name) {
                    '{0}{1}{2}' -f $kv.Name, $KeyValueSeparator, $kv.Value
                    }
                }
            }
        ))
    }
}