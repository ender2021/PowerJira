Describe "Compare-StringArraySubset" {
    Context "Should return true (string compare)" {
        It "lists match exactly" {
            $super = @("one","two","three","four")
            $sub = $super
            Compare-StringArraySubset $super $sub | Should -Be $true
        }
        It "sub has one item from super" {
            $super = @("one","two","three","four")
            $sub = @("one")
            Compare-StringArraySubset $super $sub | Should -Be $true
        }
        It "sub has multiple items from super" {
            $super = @("one","two","three","four")
            $sub = @("one","three","four")
            Compare-StringArraySubset $super $sub | Should -Be $true
        }
    }
    Context "Should return false (string compare)" {
        It "sub has no items from super" {
            $super = @("one","two","three","four")
            $sub = @("red","green","blue")
            Compare-StringArraySubset $super $sub | Should -Be $false
        }
        It "sub has some items from super, and some not in super" {
            $super = @("one","two","three","four")
            $sub = @("one","two","blue","green")
            Compare-StringArraySubset $super $sub | Should -Be $false
        }
    }
    Context "Should return true (regex)" {
        It "lists match exactly" {
            $super = @("(one|two)","(three|four)")
            $sub = @("one","two","three","four")
            Compare-StringArraySubset $super $sub -Regex | Should -Be $true
        }
        It "sub has one item from super" {
            $super = @("(one|two)","(three|four)")
            $sub = @("one")
            Compare-StringArraySubset $super $sub -Regex | Should -Be $true
        }
        It "sub has multiple items from super" {
            $super = @("(one|two|three|four)")
            $sub = @("one","three","four")
            Compare-StringArraySubset $super $sub -Regex | Should -Be $true
        }
    }
    Context "Should return false (regex)" {
        It "sub has no items from super" {
            $super = @("(one|two|three|four)")
            $sub = @("red","green","blue")
            Compare-StringArraySubset $super $sub -Regex | Should -Be $false
        }
        It "sub has some items from super, and some not in super" {
            $super = @("(one|two|three|four)")
            $sub = @("one","two","blue","green")
            Compare-StringArraySubset $super $sub -Regex | Should -Be $false
        }
    }
}