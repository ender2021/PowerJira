using module ..\..\PowerJira\classes\JiraContext.psm1

Describe "JiraContext (Class)" {
    Context "5 param constructor" {
        $user = "justin"
        $key = "an api key"
        $url = "https://my-fake-host.atlassian.net"
        $retries = 1
        $delay = 1
        $basic = "Basic anVzdGluOmFuIGFwaSBrZXk="

        It "constructor sets the host name correctly" {
            $jc = New-Object JiraContext @($user,$key,$url,$retries,$delay)

            $jc.HostName | Should -Be $url
        }
        It "constructor trims trailing slashes on the host name" {
            $jc = New-Object JiraContext @($user,$key,($url + "/"),$retries,$delay)

            $jc.HostName | Should -Be $url
        }
        It "constructor adds an Authorization key to AuthHeader hash" {
            $jc = New-Object JiraContext @($user,$key,$url,$retries,$delay)

            $jc.AuthHeader.Keys | should -Contain "Authorization"
        }
        It "constructor sets the correct value for AuthHeader.Authorization" {
            $jc = New-Object JiraContext @($user,$key,$url,$retries,$delay)

            $jc.AuthHeader.Authorization | should -Be $basic
        }
        It "constructor sets the correct value for Retries" {
            $jc = New-Object JiraContext @($user,$key,$url,$retries,$delay)

            $jc.Retries | should -Be $retries
        }
        It "constructor sets the correct value for RetryDelay" {
            $jc = New-Object JiraContext @($user,$key,$url,$retries,$delay)

            $jc.RetryDelay | should -Be $delay
        }
        It "constructor does not allow setting zero or lower for Retries" {
            { $jc = New-Object JiraContext @($user,$key,$url,0,$delay) } | Should -Throw
            { $jc = New-Object JiraContext @($user,$key,$url,-50,$delay) } | Should -Throw
        }
        It "constructor does not allow setting zero or lower for RetryDelay" {
            { $jc = New-Object JiraContext @($user,$key,$url,$retries,0) } | Should -Throw
            { $jc = New-Object JiraContext @($user,$key,$url,$retries,-50) } | Should -Throw
        }
    }
    Context "3 param constructor" {
        $user = "justin"
        $key = "an api key"
        $url = "https://my-fake-host.atlassian.net"
        $retries = 1
        $delay = 1
        $basic = "Basic anVzdGluOmFuIGFwaSBrZXk="

        It "constructor sets the host name correctly" {
            $jc = New-Object JiraContext @($user,$key,$url)

            $jc.HostName | Should -Be $url
        }
        It "constructor trims trailing slashes on the host name" {
            $jc = New-Object JiraContext @($user,$key,($url + "/"))

            $jc.HostName | Should -Be $url
        }
        It "constructor adds an Authorization key to AuthHeader hash" {
            $jc = New-Object JiraContext @($user,$key,$url)

            $jc.AuthHeader.Keys | should -Contain "Authorization"
        }
        It "constructor sets the correct value for AuthHeader.Authorization" {
            $jc = New-Object JiraContext @($user,$key,$url)

            $jc.AuthHeader.Authorization | should -Be $basic
        }
        It "constructor sets the correct value for Retries" {
            $jc = New-Object JiraContext @($user,$key,$url)

            $jc.Retries | should -Be $retries
        }
        It "constructor sets the correct value for RetryDelay" {
            $jc = New-Object JiraContext @($user,$key,$url)

            $jc.RetryDelay | should -Be $delay
        }
    }
}