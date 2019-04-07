Describe "Format-HashtableToQueryString" {
    Context "default join tokens" {
        It "joins an object with a single item correctly" {
            $toJoin = @{key="one"}
            $expected = "key=one"
            Format-HashtableToQueryString $toJoin | Should -Be $expected
        }
        It "joins an object with two properties correctly" {
            $toJoin = @{key="one";value="item"}
            $expected = @("key=one&value=item","value=item&key=one")
            Format-HashtableToQueryString $toJoin | Should -BeIn $expected
        }
    }
    Context "join tuples with ^" {
        It "joins an object with a single item correctly" {
            $toJoin = @{key="one"}
            $expected = "key^one"
            Format-HashtableToQueryString $toJoin -KeyValueSeparator "^" | Should -Be $expected
        }
        It "joins an object with two properties correctly" {
            $toJoin = @{key="one";value="item"}
            $expected = @("key^one&value^item","value^item&key^one")
            Format-HashtableToQueryString $toJoin -KeyValueSeparator "^" | Should -BeIn $expected
        }
    }
    Context "join pairs with +" {
        It "joins an object with a single item correctly" {
            $toJoin = @{key="one"}
            $expected = "key=one"
            Format-HashtableToQueryString $toJoin "+" | Should -Be $expected
        }
        It "joins an object with two properties correctly" {
            $toJoin = @{key="one";value="item"}
            $expected = @("key=one+value=item","value=item+key=one")
            Format-HashtableToQueryString $toJoin "+" | Should -BeIn $expected
        }
    }
    Context "join tuples with ^ and pairs with +" {
        It "joins an object with a single item correctly" {
            $toJoin = @{key="one"}
            $expected = "key^one"
            Format-HashtableToQueryString $toJoin "+" "^" | Should -Be $expected
        }
        It "joins an object with two properties correctly" {
            $toJoin = @{key="one";value="item"}
            $expected = @("key^one+value^item","value^item+key^one")
            Format-HashtableToQueryString $toJoin "+" "^" | Should -BeIn $expected
        }
    }
}