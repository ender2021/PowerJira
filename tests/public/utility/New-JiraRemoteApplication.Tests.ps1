Describe "New-JiraRemoteApplication" {
    Context "properties exist" {
        It "returns an object with property 'type'" {
            $obj = New-JiraRemoteApplication "some.application.namespace" "Some Application"
            $obj.Keys | Should -Contain "type"
        }
        It "returns an object with property 'name'" {
            $obj = New-JiraRemoteApplication "some.application.namespace" "Some Application"
            $obj.Keys | Should -Contain "name"
        }
    }
    Context "properties are set correctly" {
        It "returns an object with property 'type' set to the value passed to -Type" {
            $obj = New-JiraRemoteApplication "some.application.namespace" "Some Application"
            $obj.type | Should -Be "some.application.namespace"
        }
        It "returns an object with property 'name' set to the value passed to -Name" {
            $obj = New-JiraRemoteApplication "some.application.namespace" "Some Application"
            $obj.name | Should -Be "Some Application"
        }
    }
}