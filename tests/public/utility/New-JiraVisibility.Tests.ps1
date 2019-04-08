Describe "New-JiraVisibility" {
    It "accepts 'role' for -Type" {
        {New-JiraVisibility "role" "test"} | Should -Not -Throw
    }
    It "does not accept anything but 'role' for -Type" {
        {New-JiraVisibility "group" "test"} | Should -Throw "validate"
    }
    It "returns an object with property 'type'" {
        $obj = New-JiraVisibility "role" "test"
        $obj.Keys | Should -Contain "type"
    }
    It "correctly sets property 'type'" {
        $obj = New-JiraVisibility "role" "test"
        $obj.type | Should -Be "role"
    }
    It "returns an object with property 'value'" {
        $obj = New-JiraVisibility "role" "test"
        $obj.Keys | Should -Contain "value"        
    }
    It "correctly sets property 'value'" {
        $obj = New-JiraVisibility "role" "test"
        $obj.value | Should -Be "test"
    }
}