Describe "Format-QueryKvp" {
    Context "correct properties exist" {
        It 'has a "key" property' {
            (Format-QueryKvp "blah" "blue").Keys | Should -Contain "key"
        }
        It 'has a "value" property' {
            (Format-QueryKvp "blah" "blue").Keys | Should -Contain "value"
        }
    }
    Context "properties are set correctly" {
        It 'sets "key" correctly' {
            $key = "blah"
            (Format-QueryKvp $key "blue").key | Should -Be $key
        }
        It 'sets "value" correctly' {
            $value = "blue"
            (Format-QueryKvp "blah" $value).value | Should -Be $value
        }
    }
}