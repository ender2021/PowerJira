function Open-JiraSession {
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
        $RetryDelay = 1,

        # Set this switch to return the context object that is created for the session
        [Parameter()]
        [switch]
        $ReturnContext
    )
    process {
        $splat = @{
            UserName = $UserName
            Password = $Password
            HostName = $HostName
            Retries = $Retries
            RetryDelay = $RetryDelay
        }
        $context = New-JiraContext @splat
        $Global:PowerJira.OpenSession($context)
        if ($ReturnContext) { $context }
    }
}