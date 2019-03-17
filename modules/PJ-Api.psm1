function Format-JiraApiFunctionAddress($Address) {
    (&{If($Address.StartsWith("/")) {$Address.Substring(1)} else {$Address}})
}

function Invoke-JiraRestRequest {
    [CmdletBinding(DefaultParameterSetName="RestRequest")]
    Param (
        # The Jira Connection to use, if a session is not active.  The hashtable must have AuthHeader and HostName properties.
        [Parameter(Mandatory=$true)]
        [AllowNull()]
        [hashtable]
        $JiraConnection,

        # The URI path of function to invoke (do not include host name)
        [Parameter(Mandatory=$true)]
        [string]
        $FunctionAddress,

        # The HTTP method to use for the request
        [Parameter(Mandatory=$true)]
        [ValidateSet("GET","POST","PUT","PATCH","DELETE")]
        [string]
        $HttpMethod,

        # Addtional headers to be added to the request (Auth and Content Type are included automatically)
        [Parameter(Mandatory=$false)]
        [hashtable]
        $Headers=@{},

        # The body of the request.  Will be serialized to json.
        [Parameter(Mandatory=$false)]
        [hashtable]
        $Body
    )

    if($JiraConnection -eq $null) { $JiraConnection = $Global:PJ_JiraSession }
    if($JiraConnection -eq $null) {throw "No JiraConnection object provided, and no JiraSession open."}

    $sendHeaders = @{}
    $sendHeaders += $JiraConnection.AuthHeader
    $sendHeaders += $Headers

    #define url
    $hostname = $JiraConnection.HostName
    $function = Format-JiraApiFunctionAddress($FunctionAddress)
    $url = "$hostname/$function"

    if ($Body) {
        Invoke-RestMethod -Uri $url -Method $HttpMethod -ContentType 'application/json' -Headers $sendHeaders -Body (ConvertTo-Json $Body -Compress)
    } else {
        Invoke-RestMethod -Uri $url -Method $HttpMethod -ContentType 'application/json' -Headers $sendHeaders
    }
}

function New-JiraConnection($UserName,$ApiToken,$HostName) {
    # create the unencoded string
    $credentialsText = "$UserName`:$ApiToken"

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

function Open-JiraSession($UserName,$ApiToken,$HostName) {
    $Global:PJ_JiraSession = New-JiraConnection -UserName $UserName -ApiToken $ApiToken -HostName $HostName
}

function Close-JiraSession() {
    Remove-Variable PJ_JiraSession -Scope Global
}

Export-ModuleMember -Function * -Variable *