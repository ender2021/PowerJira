using module ..\..\PowerJira\classes\HashtableUtility.psm1

Describe "HashtableUtility (Class)" {
    Context "Find Depth method" {
        It "one item, depth 1" {
            $hashtable = @{one="item"}
            [HashtableUtility]::FindDepth($hashtable) | Should -Be 1
        }
        It "two items, depth 1" {
            $hashtable = @{one="item";two="things"}
            [HashtableUtility]::FindDepth($hashtable) | Should -Be 1
        }
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
        It "one item, array of hashtables, depth 3" {
            $hashtable = @{zero3=@(@{item="one"};@{item="two"})}
            [HashtableUtility]::FindDepth($hashtable) | Should -Be 3
        }
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

    Context "Compare method 'nothing' cases" {
    
        It "When both are empty it should return nothing" {
            $Left, $Right = @{}, @{}
            [HashtableUtility]::Compare($Left,$Right) | Should BeNullOrEmpty
        }
        It "When both have one identical entry it should return nothing" {
            $Left, $Right = @{ a = "x" }, @{ a = "x" }
            [HashtableUtility]::Compare($Left,$Right) | Should BeNullOrEmpty
        }
        It "When left contains a key with a null value it should return nothing" {
            $Left, $Right = @{ a = $Null }, @{}
            [Object[]]$result = [HashtableUtility]::Compare($Left,$Right)
    
            $result.Length | Should Be 1
            $result.side   | Should Be "<="
            $result.lvalue | Should Be $Null
            $result.rvalue | Should Be $Null
        }
    
        It "When right contains a key with a null value it should return nothing" {
            $Left, $Right = @{}, @{ a = $Null }
            [Object[]]$result = [HashtableUtility]::Compare($Left,$Right)
    
            $result.Length | Should Be 1
            $result.side   | Should Be "=>"
            $result.lvalue | Should Be $Null
            $result.rvalue | Should Be $Null
        }
    }  
      
    Context "Compare method 'something' cases" {
        $Left = @{ a = 1; b = 2; c = 3; f = $Null; g = 6; k = $Null }
        $Right = @{ b = 2; c = 4; e = 5; f = $Null; g = $Null; k = 7 }
        $Result = [HashtableUtility]::Compare($Left,$Right)

        It "should contain 5 differences" {
            $Result.Length | Should Be 5
        }
        It "should return a: 1 <=" {
            ($Result | Where-Object { $_.Key -eq "a" }).Side   | Should Be "<="  
            ($Result | Where-Object { $_.Key -eq "a" }).LValue | Should Be 1  
            ($Result | Where-Object { $_.Key -eq "a" }).RValue | Should Be $Null  
        }
        It "should return c: 3 <= 4" {
            ($Result | Where-Object { $_.Key -eq "c" }).Side   | Should Be "!="  
            ($Result | Where-Object { $_.Key -eq "c" }).LValue | Should Be 3  
            ($Result | Where-Object { $_.Key -eq "c" }).RValue | Should Be 4  
        }
        It "should return e: <= 5" {
            ($Result | Where-Object { $_.Key -eq "e" }).Side   | Should Be "=>"  
            ($Result | Where-Object { $_.Key -eq "e" }).LValue | Should Be $Null  
            ($Result | Where-Object { $_.Key -eq "e" }).RValue | Should Be 5  
        }
        It "should return g: 6 !=" {
            ($Result | Where-Object { $_.Key -eq "g" }).Side   | Should Be "!="  
            ($Result | Where-Object { $_.Key -eq "g" }).LValue | Should Be 6  
            ($Result | Where-Object { $_.Key -eq "g" }).RValue | Should Be $Null  
        }
        It "should return k: != 7" {
            ($Result | Where-Object { $_.Key -eq "k" }).Side   | Should Be "!="  
            ($Result | Where-Object { $_.Key -eq "k" }).LValue | Should Be $Null  
            ($Result | Where-Object { $_.Key -eq "k" }).RValue | Should Be 7  
        }       
    } 
}