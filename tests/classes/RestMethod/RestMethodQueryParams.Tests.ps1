using module ..\..\..\PowerJira\classes\RestMethod\RestQueryKvp.psm1
using module ..\..\..\PowerJira\classes\RestMethod\RestMethodQueryParams.psm1

Describe "RestMethodQueryParams (Class)" {
    $expected = @(
        New-Object RestQueryKvp @("prop1","val1")
        New-Object RestQueryKvp @("prop2","val2")
    )

    Context "Constructors" {
        $hash = @{
            prop1 = "val1"
            prop2 = "val2"
        }

        It "blank constructor sets Params property to blank array" {
            $rmqp = New-Object RestMethodQueryParams

            $rmqp.Params | Should -Be @()
        }
        It "hash const
        ructor populates Params property correctly" {
            $rmqp = New-Object RestMethodQueryParams $hash

            $rmqp.Params | Should -Be $expected
        }
        It "KVP array constructor populates Params property correctly" {
            $rmqp = New-Object RestMethodQueryParams @(,$expected)

            $rmqp.Params | Should -Be $expected
        }
    }
    Context "Add method" {
        It "Add correctly creates a new KVP element" {
            $rmqp = New-Object RestMethodQueryParams
            $rmqp.Add($expected[0].Key, $expected[0].Value)

            $rmqp.Params | Should -Contain $expected[0]
        }
    }
    Context "ToString method" {
        It "Correctly formats a single element" {
            $rmqp = New-Object RestMethodQueryParams @(,$expected[0])
            $expectedString = "?prop1=val1"

            $rmqp.ToString() | Should -Be $expectedString
        }
        It "Correctly formats a multiple elements" {
            $rmqp = New-Object RestMethodQueryParams @(,$expected)
            $expectedString = "?prop1=val1&prop2=val2"

            $rmqp.ToString() | Should -Be $expectedString
        }
    }
}