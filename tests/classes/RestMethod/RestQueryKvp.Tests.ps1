using module ..\..\..\PowerJira\classes\RestMethod\RestQueryKvp.psm1

Describe "RestQueryKvp (Class)" {
    Context "Constructors" {
        $key = "key"
        $valueText = "value"
        $valueDate = Get-Date

        It "constructor sets the Key property" {
            $kvp = New-Object RestQueryKvp @($key,$valueText)

            $kvp.Key | Should -Be $key
        }
        It "constructor sets a simple text value" {
            $kvp = New-Object RestQueryKvp @($key,$valueText)

            $kvp.Value | Should -Be $valueText
        }
        It "constructor sets a date value" {
            $kvp = New-Object RestQueryKvp @($key,$valueDate)

            $dateText = $valueDate.ToString()
            $kvp.Value | Should -Be $dateText
        }
        It "constructor does not accept a null key" {
            { New-Object RestQueryKvp @($null,$valueDate) } | Should -Throw
        }
        It "constructor does not accept a blank key" {
            { New-Object RestQueryKvp @("",$valueDate) } | Should -Throw
        }
        It "constructor does not accept a null value" {
            { New-Object RestQueryKvp @($key,$null) } | Should -Throw
        }
    }
    Context "JoinKvp" {
        $key1 = "key1"
        $key2 = "key2"
        $val1 = "val1"
        $val2 = "val2"

        $kvp1 = New-Object RestQueryKvp @($key1,$val1)
        $kvp2 = New-Object RestQueryKvp @($key2,$val2)

        $kvJoin = "="
        $pJoin = ","

        It "joins a single pair correctly" {
            $expected = "$key1$kvJoin$val1"
            [RestQueryKvp]::JoinKvp($kvp1,$pJoin,$kvJoin) | Should -Be $expected
        }
        It "joins two pairs correctly" {
            $expected = "$key1$kvJoin$val1$pjoin$key2$kvJoin$val2"
            [RestQueryKvp]::JoinKvp(@($kvp1,$kvp2),$pJoin,$kvJoin) | Should -Be $expected
        }
    }
}