$MockNewJiraConnection = {
    @{
        AuthHeader = @{Authorization="UserName-Password"}
        HostName = "https://test.domain/"
        Retry = @{
            Max = 1
            Delay = 1
        }
    } 
}