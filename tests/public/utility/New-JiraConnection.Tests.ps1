Describe "New-JiraConnection" {
    Context "PlainText" {
        It "produces an object with property 'AuthHeader'" {
            $conn = New-JiraConnection "justin" "password" "host.name"
            $conn.Keys | Should -Contain "AuthHeader"
        }
        It "produces an object with property 'AuthHeader' which has property 'Authorization'" {
            $conn = New-JiraConnection "justin" "password" "host.name"
            $conn.AuthHeader.Keys | Should -Contain "Authorization"
        }
        It "property 'AuthHeader.Authorization' is set correctly" {
            $conn = New-JiraConnection "justin" "password" "host.name"
            $conn.AuthHeader.Authorization | Should -Be "Basic anVzdGluOnBhc3N3b3Jk"
        }
        It "produces an object with property 'HostName'" {
            $conn = New-JiraConnection "justin" "password" "host.name"
            $conn.Keys | Should -Contain "HostName"
        }
        It "property 'HostName' is set correctly" {
            $conn = New-JiraConnection "justin" "password" "host.name"
            $conn.HostName | Should -Be "host.name"
        }
    }
}