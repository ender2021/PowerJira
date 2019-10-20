class JiraContext {
    #####################
    # HIDDEN PROPERTIES #
    #####################
    
    #####################
    # PUBLIC PROPERTIES #
    #####################

    [pscustomobject]
    $AuthHeader

    [string]
    $HostName

    ################
    # CONSTRUCTORS #
    ################

    JiraContext(
        [string]$UserName,
        [string]$ApiKey,
        [string]$HostName
    ){
        # create the unencoded string
        $credentialsText = "$UserName`:$ApiKey"

        # encode the string in base64
        $credentialsBytes = [System.Text.Encoding]::UTF8.GetBytes($credentialsText)
        $encodedCredentials = [Convert]::ToBase64String($credentialsBytes)

        # format the host name
        $formattedHost = (&{If($HostName.EndsWith("/")) {$HostName.Substring(0,$HostName.Length-1)} else {$HostName}})

        # set the object properties
        $this.AuthHeader = @{Authorization="Basic $encodedCredentials"}
        $this.HostName = $formattedHost
    }

    ##################
    # HIDDEN METHODS #
    ##################

    ##################
    # PUBLIC METHODS #
    ##################
}