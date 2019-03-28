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