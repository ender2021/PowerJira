. $PSScriptRoot\..\..\..\mocks\MockRestMethod.ps1

Describe "Invoke-JiraGetAvatars (Function)" {
    Mock "New-Object" $MockRestMethod -ParameterFilter { $TypeName -and $TypeName -eq "RestMethod" } -ModuleName PowerJira

    Context "Param Validation" {
        It "only accepts 'issuetype' or 'project' for Type" {
            { Invoke-JiraGetAvatars -Type "issuetype" -Id 1 } | Should -Not -Throw
            { Invoke-JiraGetAvatars -Type "project" -Id 1 } | Should -Not -Throw
            { Invoke-JiraGetAvatars -Type "faketype" -Id 1 } | Should -Throw
        }
    }
    Context "Rest Arguments" {
        $Type = "issuetype"
        $Id = 10000

        It "passes the correct function path" {
            $expected = "/rest/api/2/universal_avatar/type/$Type/owner/$Id"

            $result = Invoke-JiraGetAvatars -Type $Type -Id $Id
            $result.ArgumentList[0] | Should -Be $expected
        }
        It "passes the correct http verb" {
            $expected = "GET"

            $result = Invoke-JiraGetAvatars -Type $Type -Id $Id
            $result.ArgumentList[1] | Should -Be $expected
        }
    }
}