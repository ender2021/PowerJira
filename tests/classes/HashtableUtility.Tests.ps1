using module ..\..\PowerJira\classes\HashtableUtility.psm1

Describe "HashtableUtility (Class)" {
    Context "depth 1" {
        It "one item, depth 1" {
            $hashtable = @{one="item"}
            [HashtableUtility]::FindDepth($hashtable) | Should -Be 1
        }
        It "two items, depth 1" {
            $hashtable = @{one="item";two="things"}
            [HashtableUtility]::FindDepth($hashtable) | Should -Be 1
        }
    }
    Context "depth 2" {
        It "one item, depth 2" {
            $hashtable = @{one=@{deep="item"}}
            [HashtableUtility]::FindDepth($hashtable) | Should -Be 2
        }
        It "one item, an array, depth 2" {
            $hashtable = @{one=@("item")}
            [HashtableUtility]::FindDepth($hashtable) | Should -Be 2
        }
        It "one item, an empty array, depth 2" {
            $hashtable = @{one=@()}
            [HashtableUtility]::FindDepth($hashtable) | Should -Be 2
        }
        It "two items, both depth 2" {
            $hashtable = @{one=@{deep="item"};two=@{deep="item"}}
            [HashtableUtility]::FindDepth($hashtable) | Should -Be 2
        }
        It "three items, deepest depth 2" {
            $hashtable = @{one=@{deep="item"};two="string";three=@{deep="item"}}
            [HashtableUtility]::FindDepth($hashtable) | Should -Be 2
        }
        It "three items, deepest depth 2 (different arrangement)" {
            $hashtable = @{one="string";two=@{deep="item"};three="string"}
            [HashtableUtility]::FindDepth($hashtable) | Should -Be 2
        }
        It "three items, including a string array, depth 2" {
            $hashtable = @{one="string";two=@{deep="item"};three=@("string")}
            [HashtableUtility]::FindDepth($hashtable) | Should -Be 2
        }
    }
    Context "depth 3" {
        It "one item, array of hashtables, depth 3" {
            $hashtable = @{zero3=@(@{item="one"};@{item="two"})}
            [HashtableUtility]::FindDepth($hashtable) | Should -Be 3
        }
    }
    Context "depth 4" {
        It "one item, depth 4" {
            $hashtable = @{zero3=@{one=@{two=@{three="item"}}}}
            [HashtableUtility]::FindDepth($hashtable) | Should -Be 4
        }
        It "one item, array of 2 deep hashtables" {
            $hashtable = @{zero=@(@{two=@{three="item"}};@{two=@{three="item"}})}
            [HashtableUtility]::FindDepth($hashtable) | Should -Be 4
        }
        It "two items, array of hashtables + 3 deep hashtable" {
            $hashtable = @{zero3=@{one=@{two=@{three="item"}}};zero3arr=@(@{item="one"};@{item="two"})}
            [HashtableUtility]::FindDepth($hashtable) | Should -Be 4
        }
        It "two items, array of 2 deep hashtables + 3 deep hashtable" {
            $hashtable = @{zero3=@{one=@{two=@{three="item"}}};zero3arr=@(@{two=@{three="item"}};@{two=@{three="item"}})}
            [HashtableUtility]::FindDepth($hashtable) | Should -Be 4
        }
    }
    Context "depth 6" {
        It "one item, depth 6" {
            $hashtable = @{zero=@{one=@{two=@{three=@{four=@{five="item"}}}}}}
            [HashtableUtility]::FindDepth($hashtable) | Should -Be 6
        }
        It "two items, one depth 4, one depth 6" {
            $hashtable = @{zero5=@{one=@{two=@{three=@{four=@{five="item"}}}}};zero3=@{one=@{two=@{three="item"}}}}
            [HashtableUtility]::FindDepth($hashtable) | Should -Be 6
        }
        It "two items, one depth 4, one depth 6 (reversed)" {
            $hashtable = @{zero3=@{one=@{two=@{three="item"}}};zero5=@{one=@{two=@{three=@{four=@{five="item"}}}}}}
            [HashtableUtility]::FindDepth($hashtable) | Should -Be 6
        }
    }
}