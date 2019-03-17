function Format-JiraApiFunctionAddress($Address) {
    (&{If($Address.StartsWith("/")) {$Address.Substring(1)} else {$Address}})
}

function Invoke-JiraRestRequest($JiraConnection=$Global:JA_JiraSession,$FunctionAddress,$HttpMethod,$Headers=@{},$Body) {
    
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
    $Global:JA_JiraSession = New-JiraConnection -UserName $UserName -ApiToken $ApiToken -HostName $HostName
}

function Close-JiraSession() {
    Remove-Variable JA_JiraSession -Scope Global
}

Export-ModuleMember -Function * -Variable *