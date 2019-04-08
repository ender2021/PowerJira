Describe "Format-UnixTimestamp" {
    It "correctly gets the number of ticks since the Unix epoch" {
        Format-UnixTimestamp "07/20/1985" | Should -Be 490665600
    }
}