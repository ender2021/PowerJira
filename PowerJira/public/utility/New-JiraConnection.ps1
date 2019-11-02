function New-JiraConnection {
    [CmdletBinding(DefaultParameterSetName="PlainText")]
    param (
        # The Jira username of the user performing actions
        [Parameter(Mandatory,Position=0,ParameterSetName="PlainText")]
        [string]
        $UserName,

        # The Jira password (or API Token) of the user performing actions
        [Parameter(Mandatory,Position=1,ParameterSetName="PlainText")]
        [string]
        $Password,

        # The hostname of the Jira instance to interact with (e.g. https://yourjirasite.atlassian.net/)
        [Parameter(Mandatory,Position=2)]
        [string]
        $HostName,

        # Configure the number of retry attempts for rest calls
        [Parameter(Position=3)]
        [int32]
        $Retries = 1,

        # Configure the delay (in seconds) between retry attempts
        [Parameter(Position=4)]
        [int32]
        $RetryDelay = 1
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
        Retry = @{
            Max = $Retries
            Delay = $RetryDelay
        }
    }    
}