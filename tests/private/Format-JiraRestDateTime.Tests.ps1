Describe "Format-JiraRestDateTime" {
    Context "Normal Format" {
        It "is formatted correctly" {
            $date = Get-Date "1985-07-20 2:00:00"
            $expected = "1985-07-20T02:0000.000"
            Format-JiraRestDateTime $date | Should -Be $expected
        }
    }
    Context "Simple Format" {
        It "is formatted correctly" {
            $date = Get-Date "1985-07-20 2:00:00"
            $expected = "1985-07-20T02:00:00.0000000"
            Format-JiraRestDateTime $date -Simple | Should -Be $expected
        }
    }
}