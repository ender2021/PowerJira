Describe "Format-KvpArrayToQueryString" {
    Context "default join tokens" {
        It "joins a single item correctly" {
            $toJoin = @(@{key="one";value="item"})
            $expected = "one=item"
            Format-KvpArrayToQueryString $toJoin | Should -Be $expected
        }
        It "joins two unique items correctly" {
            $toJoin = @(@{key="one";value="item"},@{key="two";value="things"})
            $expected = "one=item&two=things"
            Format-KvpArrayToQueryString $toJoin | Should -Be $expected
        }
        It "joins three unique items correctly" {
            $toJoin = @(@{key="one";value="item"},@{key="two";value="things"},@{key="three";value="unique"})
            $expected = "one=item&two=things&three=unique"
            Format-KvpArrayToQueryString $toJoin | Should -Be $expected
        }
        It "joins three non-unique items correctly" {
            $toJoin = @(@{key="one";value="item"},@{key="two";value="things"},@{key="two";value="unique"})
            $expected = "one=item&two=things&two=unique"
            Format-KvpArrayToQueryString $toJoin | Should -Be $expected
        }
    }
    Context "join tuples with ^" {
        It "joins a single item correctly" {
            $toJoin = @(@{key="one";value="item"})
            $expected = "one^item"
            Format-KvpArrayToQueryString $toJoin -KeyValueSeparator "^" | Should -Be $expected
        }
        It "joins two unique items correctly" {
            $toJoin = @(@{key="one";value="item"},@{key="two";value="things"})
            $expected = "one^item&two^things"
            Format-KvpArrayToQueryString $toJoin -KeyValueSeparator "^" | Should -Be $expected
        }
        It "joins three unique items correctly" {
            $toJoin = @(@{key="one";value="item"},@{key="two";value="things"},@{key="three";value="unique"})
            $expected = "one^item&two^things&three^unique"
            Format-KvpArrayToQueryString $toJoin -KeyValueSeparator "^" | Should -Be $expected
        }
        It "joins three non-unique items correctly" {
            $toJoin = @(@{key="one";value="item"},@{key="two";value="things"},@{key="two";value="unique"})
            $expected = "one^item&two^things&two^unique"
            Format-KvpArrayToQueryString $toJoin -KeyValueSeparator "^" | Should -Be $expected
        }
    }
    Context "join pairs with +" {
        It "joins a single item correctly" {
            $toJoin = @(@{key="one";value="item"})
            $expected = "one=item"
            Format-KvpArrayToQueryString $toJoin "+" | Should -Be $expected
        }
        It "joins two unique items correctly" {
            $toJoin = @(@{key="one";value="item"},@{key="two";value="things"})
            $expected = "one=item+two=things"
            Format-KvpArrayToQueryString $toJoin "+" | Should -Be $expected
        }
        It "joins three unique items correctly" {
            $toJoin = @(@{key="one";value="item"},@{key="two";value="things"},@{key="three";value="unique"})
            $expected = "one=item+two=things+three=unique"
            Format-KvpArrayToQueryString $toJoin "+" | Should -Be $expected
        }
        It "joins three non-unique items correctly" {
            $toJoin = @(@{key="one";value="item"},@{key="two";value="things"},@{key="two";value="unique"})
            $expected = "one=item+two=things+two=unique"
            Format-KvpArrayToQueryString $toJoin "+" | Should -Be $expected
        }
    }
    Context "join tuples with ^ and pairs with +" {
        It "joins a single item correctly" {
            $toJoin = @(@{key="one";value="item"})
            $expected = "one^item"
            Format-KvpArrayToQueryString $toJoin "+" "^" | Should -Be $expected
        }
        It "joins two unique items correctly" {
            $toJoin = @(@{key="one";value="item"},@{key="two";value="things"})
            $expected = "one^item+two^things"
            Format-KvpArrayToQueryString $toJoin "+" "^" | Should -Be $expected
        }
        It "joins three unique items correctly" {
            $toJoin = @(@{key="one";value="item"},@{key="two";value="things"},@{key="three";value="unique"})
            $expected = "one^item+two^things+three^unique"
            Format-KvpArrayToQueryString $toJoin "+" "^" | Should -Be $expected
        }
        It "joins three non-unique items correctly" {
            $toJoin = @(@{key="one";value="item"},@{key="two";value="things"},@{key="two";value="unique"})
            $expected = "one^item+two^things+two^unique"
            Format-KvpArrayToQueryString $toJoin "+" "^" | Should -Be $expected
        }
    }
}