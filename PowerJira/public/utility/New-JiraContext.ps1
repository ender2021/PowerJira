function New-JiraContext {
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
        $HostName
    )
    begin {}
    process {
        return New-Object JiraContext @($UserName,$Password,$HostName)
    }
    end {}
}