function Format-JiraRestDateTime {
    [CmdletBinding(DefaultParameterSetName="DefaultParams")]
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

function Invoke-JiraRestRequest {
    [CmdletBinding(DefaultParameterSetName="RestRequest")]
    param (
        # The Jira Connection to use, if a session is not active.  The hashtable must have AuthHeader and HostName properties.
        [Parameter(Mandatory=$true)]
        [AllowNull()]
        [hashtable]
        $JiraConnection,

        # The URI path of function to invoke (do not include host name)
        [Parameter(Mandatory=$true)]
        [string]
        $FunctionPath,

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

        if (($null -ne $Body) -and ($Body.Count -gt 0)) {
            $b = if($HttpMethod -eq "GET") {$Body} else {ConvertTo-Json $Body -Compress}
            Invoke-RestMethod -Uri $uri -Method $HttpMethod -ContentType 'application/json' -Headers $sendHeaders -Body $b
        } else {
            Invoke-RestMethod -Uri $uri -Method $HttpMethod -ContentType 'application/json' -Headers $sendHeaders
        }
    }
}

function New-JiraConnection {
    [CmdletBinding(DefaultParameterSetName="PlainText")]
    param (
        # The Jira username of the user performing actions
        [Parameter(Mandatory=$true)]
        [string]
        $UserName,

        # The Jira password (or API Token) of the user performing actions
        [Parameter(Mandatory=$true)]
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
        [Parameter(Mandatory=$true)]
        [string]
        $UserName,

        # The Jira password (or API Token) of the user performing actions
        [Parameter(Mandatory=$true)]
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

Export-ModuleMember -Function * -Variable *