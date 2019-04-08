Describe "Close-JiraSession" {
    It "does not remove property 'Session' of the global object" {
        $Global:PowerJira.Session = @{AuthHeader=@{Authorization="Basic anVzdGluOnBhc3N3b3Jk"};HostName="host.name"}        
        Close-JiraSession
        $Global:PowerJira.Keys | Should -Contain "Session"
    }
    It "sets property 'Session' of the global object to null" {
        $Global:PowerJira.Session = @{AuthHeader=@{Authorization="Basic anVzdGluOnBhc3N3b3Jk"};HostName="host.name"}        
        Close-JiraSession
        $Global:PowerJira.Session | Should -BeNullOrEmpty
    }
}