Describe "Open-JiraSession" {
    Context "PlainText" {
        It "sets property 'Session' of the global object" {
            $Global:PowerJira.Session = $null
            Open-JiraSession "justin" "password" "host.name"
            $Global:PowerJira.Session | Should -Not -BeNullOrEmpty
        }
        It "sets property 'Session.AuthHeader' on the global object" {
            $Global:PowerJira.Session = $null
            Open-JiraSession "justin" "password" "host.name"
            $Global:PowerJira.Session.Keys | Should -Contain "AuthHeader"
        }
        It "sets property 'Session.AuthHeader.Authorization' on the global object" {
            $Global:PowerJira.Session = $null
            Open-JiraSession "justin" "password" "host.name"
            $Global:PowerJira.Session.AuthHeader.Keys | Should -Contain "Authorization"
        }
        It "correctly sets property 'Session.AuthHeader.Authorization' of the global object" {
            $Global:PowerJira.Session = $null
            Open-JiraSession "justin" "password" "host.name"
            $Global:PowerJira.Session.AuthHeader.Authorization | Should -Be "Basic anVzdGluOnBhc3N3b3Jk"
        }
        It "sets property 'Session.HostName' on the global object" {
            $Global:PowerJira.Session = $null
            Open-JiraSession "justin" "password" "host.name"
            $Global:PowerJira.Session.Keys | Should -Contain "HostName"
        }
        It "correctly sets property 'Session.HostName' on the global object" {
            $Global:PowerJira.Session = $null
            Open-JiraSession "justin" "password" "host.name"
            $Global:PowerJira.Session.HostName | Should -Be "host.name"
        }
    }
}