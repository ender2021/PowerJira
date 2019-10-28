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

        # Set this switch to return the context object that is created for the session
        [Parameter()]
        [switch]
        $ReturnContext
    )
    process {
        $context = New-JiraContext $JiraCredentials.UserName $JiraCredentials.ApiToken $JiraCredentials.HostName
        $Global:PowerJira.OpenSession($context)
        if ($ReturnContext) { $context }
    }
}