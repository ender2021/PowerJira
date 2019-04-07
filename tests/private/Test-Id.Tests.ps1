Describe "Private Test-Id tests" {
    Context "should return true" {
        It 'for an integer' {
            Test-Id 12345 | Should -Be $true
        }    
        It 'for a really short integer' {
            Test-Id 1 | Should -Be $true
        }
        It 'for a really big integer' {
            Test-Id 12345678901234567890 | Should -Be $true
        }
    }
    Context "should return false" {
        It 'should return false for a non-integer' {
            Test-Id "blargh" | Should -Be $false
        }
        It 'should return false for a decimal' {
            Test-Id 123.45 | Should -Be $false
        }
        It 'should return false for a non-string object' {
            Test-Id (Get-Date) | Should -Be $false
        }
    }
}