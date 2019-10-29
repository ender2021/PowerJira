using module ..\..\..\PowerJira\classes\RestMethod\RestMethodBody.psm1

Describe "RestMethodBody (Class)" {
    $bodyStr = "this is my raw body string"

    Context "Constructors" {
        It "blank constructor sets BodyString property to blank string" {
            $rmb = New-Object RestMethodBody

            $rmb.BodyString | Should -Be ""
        }
        It "string constructor sets BodyString property correctly" {
            $rmb = New-Object RestMethodBody $bodyStr

            $rmb.BodyString | Should -Be $bodyStr
        }
    }
    Context "ToString method" {
        It "ToString returns the BodyString property" {
            $rmb = New-Object RestMethodBody $bodyStr

            $rmb.ToString() | Should -Be $rmb.BodyString
        }
    }
}