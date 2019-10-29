using module ..\..\..\PowerJira\classes\RestMethod\RestMethodJsonBody.psm1

. ..\..\..\PowerJira\private\Compare-Hashtable.ps1

Describe "RestMethodJsonBody (Class)" {
    $bodyHash1 = @{
        prop1 = "val1"
    }
    $bodyHash2 = @{
        prop1 = "val1"
        prop2 = "val2"
    }

    Context "Constructors" {
        It "blank constructor initializes Values property to empty hashtable" {
            $rmjb = New-Object RestMethodJsonBody

            $rmjb.Values | Should -Not -Be $null
            $rmjb.Values | Should -BeNullOrEmpty
        }
        It "hash constructor sets Values property correctly" {
            $rmjb = New-Object RestMethodJsonBody $bodyHash2

            Compare-Hashtable $rmjb.Values $bodyHash2 | Should -BeNullOrEmpty
        }
    }
    Context "ToString method" {
        $expected1 = '{"prop1":"val1"}'
        $expected2Possibles = @(
            '{"prop2":"val2","prop1":"val1"}'
            '{"prop1":"val1","prop2":"val2"}'
        )
        It "ToString returns the correct rendering of one value" {
            $rmjb = New-Object RestMethodJsonBody $bodyHash1

            $rmjb.ToString() | Should -Be $expected1
        }
        It "ToString returns the correct rendering of two values" {
            $rmjb = New-Object RestMethodJsonBody $bodyHash2

            $rmjb.ToString() | Should -BeIn $expected2Possibles
        }
        It "ToString returns the correct rendering of a hash with depth greater than 2 (zero-based)" {
            $deep = @{one=@{two=@{three=@{four="end"}}}}
            $expectedStr = '{"one":{"two":{"three":{"four":"end"}}}}'
            $rmjb = New-Object RestMethodJsonBody $deep

            $rmjb.ToString() | Should -Be $expectedStr
        }
    }
}