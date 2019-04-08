Describe "Find-HashtableDepth" {
    Context "Depth 0" {
        It "one item, depth 0" {
            $hashtable = @{one="item"}
            Find-HashtableDepth $hashtable | Should -Be 0
        }
        It "two items, depth 0" {
            $hashtable = @{one="item";two="things"}
            Find-HashtableDepth $hashtable | Should -Be 0
        }
    }
    Context "Depth 1" {
        It "one item, depth 1" {
            $hashtable = @{one=@{deep="item"}}
            Find-HashtableDepth $hashtable | Should -Be 1
        }
        It "one item, an array, depth 1" {
            $hashtable = @{one=@("item")}
            Find-HashtableDepth $hashtable | Should -Be 1
        }
        It "one item, an empty array, depth 1" {
            $hashtable = @{one=@()}
            Find-HashtableDepth $hashtable | Should -Be 1
        }
        It "two items, both depth 1" {
            $hashtable = @{one=@{deep="item"};two=@{deep="item"}}
            Find-HashtableDepth $hashtable | Should -Be 1
        }
        It "three items, deepest depth 1" {
            $hashtable = @{one=@{deep="item"};two="string";three=@{deep="item"}}
            Find-HashtableDepth $hashtable | Should -Be 1
        }
        It "three items, deepest depth 1 (different arrangement)" {
            $hashtable = @{one="string";two=@{deep="item"};three="string"}
            Find-HashtableDepth $hashtable | Should -Be 1
        }
        It "three items, including a string array, depth 1" {
            $hashtable = @{one="string";two=@{deep="item"};three=@("string")}
            Find-HashtableDepth $hashtable | Should -Be 1
        }
    }
    Context "Depth 2" {
        It "one item, array of hashtables, depth 2" {
            $hashtable = @{zero3=@(@{item="one"};@{item="two"})}
            Find-HashtableDepth $hashtable | Should -Be 2
        }
    }
    Context "Depth 3" {
        It "one item, depth 3" {
            $hashtable = @{zero3=@{one=@{two=@{three="item"}}}}
            Find-HashtableDepth $hashtable | Should -Be 3
        }
        It "one item, array of 2 deep hashtables" {
            $hashtable = @{zero=@(@{two=@{three="item"}};@{two=@{three="item"}})}
            Find-HashtableDepth $hashtable | Should -Be 3
        }
        It "two items, array of hashtables + 3 deep hashtable" {
            $hashtable = @{zero3=@{one=@{two=@{three="item"}}};zero3arr=@(@{item="one"};@{item="two"})}
            Find-HashtableDepth $hashtable | Should -Be 3
        }
        It "two items, array of 2 deep hashtables + 3 deep hashtable" {
            $hashtable = @{zero3=@{one=@{two=@{three="item"}}};zero3arr=@(@{two=@{three="item"}};@{two=@{three="item"}})}
            Find-HashtableDepth $hashtable | Should -Be 3
        }
    }
    Context "Depth 5" {
        It "one item, depth 5" {
            $hashtable = @{zero=@{one=@{two=@{three=@{four=@{five="item"}}}}}}
            Find-HashtableDepth $hashtable | Should -Be 5
        }
        It "two items, one depth 3, one depth 5" {
            $hashtable = @{zero5=@{one=@{two=@{three=@{four=@{five="item"}}}}};zero3=@{one=@{two=@{three="item"}}}}
            Find-HashtableDepth $hashtable | Should -Be 5
        }
        It "two items, one depth 3, one depth 5 (reversed)" {
            $hashtable = @{zero3=@{one=@{two=@{three="item"}}};zero5=@{one=@{two=@{three=@{four=@{five="item"}}}}}}
            Find-HashtableDepth $hashtable | Should -Be 5
        }
    }
}