using module ..\..\PowerJira\classes\JiraContext.psm1

Describe "JiraContext (Class)" {
    Context "Constructors" {
        $url = "https://my-fake-host.atlassian.net"
        $user = "justin"
        $key = "an api key"
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
    }
}