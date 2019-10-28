using module ..\..\PowerJira\classes\JiraDateTime.psm1

Describe "JiraDateTime (Class)" {
    Context "Constructors" {
        $expected = Get-Date "1985-07-20 2:00:00"

        It "blank constructor sets DateTime property using Get-Date" {
            Mock Get-Date { return $expected }
            $jdt = New-Object JiraDateTime
            $jdt.DateTime | Should -Be $expected
        }
        It "datetime constructor accepts datetime and sets it to DateTime property" {
            $jdt = New-Object JiraDateTime $expected
            $jdt.DateTime | Should -Be $expected
        }
    }
    Context "Simple Format" {
        $date = Get-Date "1985-07-20 2:00:00"
        $expected = "1985-07-20T02:00:00.0000000"

        It "static SimpleFormat returns value correctly formatted" {
            [JiraDateTime]::SimpleFormat($date) | Should -Be $expected
        }
        It "instance SimpleFormat returns value correctly formatted" {
            $jdt = New-Object JiraDateTime $date
            $jdt.SimpleFormat() | Should -Be $expected
        }
    }
    Context "Complex Format" {
        $date = Get-Date "1985-07-20 2:00:00"
        $expected = "1985-07-20T02:0000.000"
            
        It "static ComplexFormat returns value correctly formatted" {
            [JiraDateTime]::ComplexFormat($date) | Should -Be $expected
        }
        It "instance ComplexFormat returns value correctly formatted" {
            $jdt = New-Object JiraDateTime $date
            $jdt.ComplexFormat() | Should -Be $expected
        }
    }
}