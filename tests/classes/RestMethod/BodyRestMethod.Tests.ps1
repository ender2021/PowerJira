using module ..\..\..\PowerJira\classes\HashtableUtility.psm1
using module ..\..\..\PowerJira\classes\JiraContext.psm1
using module ..\..\..\PowerJira\classes\PowerJiraGlobal.psm1
using module ..\..\..\PowerJira\classes\RestMethod\BodyRestMethod.psm1
using module ..\..\..\PowerJira\classes\RestMethod\RestMethodBody.psm1
using module ..\..\..\PowerJira\classes\RestMethod\RestMethodJsonBody.psm1
using module ..\..\..\PowerJira\classes\RestMethod\RestMethodQueryParams.psm1

. $PSScriptRoot\..\..\mocks\Mock-InvokeRestMethod.ps1

Describe "BodyRestMethod (Class)" {
    $simplePath = "path"
    $get = "GET"
    $defaultContentType = "application/json"
    $jsonBody = New-Object RestMethodJsonBody @{
        prop1 = "val1"
        prop2 = "val2"
    }
    $simpleBody = New-Object RestMethodBody "this is a simple body"

    Context "No Query String Constructor" {
        It "no query constructor sets FunctionPath, HttpMethod, and Simple Body" {
            $rm = New-Object BodyRestMethod $($simplePath,$get,$simpleBody)

            $rm.FunctionPath | Should -Be $simplePath
            $rm.HttpMethod | Should -Be $get
            $rm.Body | Should -Be $simpleBody
        }
        It "no query constructor sets FunctionPath, HttpMethod, and Json Body" {
            $rm = New-Object BodyRestMethod $($simplePath,$get,$jsonBody)

            $rm.FunctionPath | Should -Be $simplePath
            $rm.HttpMethod | Should -Be $get
            $rm.Body | Should -Be $jsonBody
        }
        It "no query constructor initializes Headers and ContentType" {
            $rm = New-Object BodyRestMethod $($simplePath,$get,$simpleBody)

            $rm.Headers | Should -Not -Be $null
            $rm.Headers | Should -BeNullOrEmpty
            $rm.ContentType | Should -Be $defaultContentType
        }
        It "no query constructor should trim leading slashes from FunctionPath" {
            $rm = New-Object BodyRestMethod $("/$simplePath",$get,$simpleBody)

            $rm.FunctionPath | Should -Be $simplePath
        }
        It "no query constructor should validate blank FunctionPath" {
            { $rm = New-Object BodyRestMethod $("",$get,$simpleBody) } | Should -Throw
        }
        It "no query constructor should validate HttpVerb" {
            { $rm = New-Object BodyRestMethod $($simplePath,"JOUST",$simpleBody) } | Should -Throw
        }
    }
    Context "Query String Constructor" {
        $qs = New-Object RestMethodQueryParams @{
            prop1 = "val1"
            prop2 = "val2"
        }

        It "qs constructor sets FunctionPath, HttpMethod, Simple Body, and the query params" {
            $rm = New-Object BodyRestMethod @($simplePath,$get,$qs,$simpleBody)

            $rm.FunctionPath | Should -Be $simplePath
            $rm.HttpMethod | Should -Be $get
            $rm.Body | Should -Be $simpleBody
            $rm.Query | Should -Be $qs
        }
        It "no query constructor sets FunctionPath, HttpMethod, and Json Body, and the query params" {
            $rm = New-Object BodyRestMethod $($simplePath,$get,$qs,$jsonBody)

            $rm.FunctionPath | Should -Be $simplePath
            $rm.HttpMethod | Should -Be $get
            $rm.Body | Should -Be $jsonBody
            $rm.Query | Should -Be $qs
        }
        
        It "no query constructor initializes Headers and ContentType" {
            $rm = New-Object BodyRestMethod $($simplePath,$get,$qs,$simpleBody)

            $rm.Headers | Should -Not -Be $null
            $rm.Headers | Should -BeNullOrEmpty
            $rm.ContentType | Should -Be $defaultContentType
        }
        It "qs constructor should trim leading slashes from FunctionPath" {
            $rm = New-Object BodyRestMethod $("/$simplePath",$get,$qs,$simpleBody)

            $rm.FunctionPath | Should -Be $simplePath
        }
        It "qs constructor should validate blank FunctionPath" {
            { $rm = New-Object BodyRestMethod $("",$get,$qs,$simpleBody) } | Should -Throw
        }
        It "qs constructor should validate HttpVerb" {
            { $rm = New-Object BodyRestMethod $($simplePath,"JOUST",$qs,$simpleBody) } | Should -Throw
        }
    }
    Context "Invoke Method (no query)" {
        $uri = "https://my-uri.com"
        $jc = New-Object JiraContext @("1","2",$uri)
        Mock "Invoke-RestMethod" $MockInvokeRestMethod -ModuleName BodyRestMethod
        $simpleRm = New-Object BodyRestMethod @($simplePath,$get,$simpleBody)
        $result = $simpleRm.Invoke($jc)

        It "passes Uri to Invoke-RestMethod correctly" {
            $result.Uri | Should -Be "$uri/$simplePath"
        }
        It "passes Method to Invoke-RestMethod correctly" {
            $result.Method | Should -Be $get
        }
        It "passes ContentType to Invoke-RestMethod correctly" {
            $result.ContentType | Should -Be $defaultContentType
        }
        It "passes Headers to Invoke-RestMethod correctly" {
            [HashtableUtility]::Compare($result.Headers,$jc.AuthHeader) | Should -BeNullOrEmpty
        }
        It "passes Body to Invoke-RestMethod correctly (string body)" {
            $result.Body | Should -Be $simpleBody.BodyString
        }
        It "passes Body to Invoke-RestMethod correctly (json body)" {
            $jsonRm = New-Object BodyRestMethod @($simplePath,$get,$jsonBody)
            
            $jsonRm.Invoke($jc).Body | Should -Be $jsonBody.ToString()
        }
    }
    Context "Invoke Method (with query)" {
        $uri = "https://my-uri.com"
        $jc = New-Object JiraContext @("1","2",$uri)
        $qs = New-Object RestMethodQueryParams @{
            prop1 = "val1"
        }
        Mock "Invoke-RestMethod" $MockInvokeRestMethod -ModuleName BodyRestMethod
        $rm = New-Object BodyRestMethod @($simplePath,$get,$qs,$simpleBody)
        $result = $rm.Invoke($jc)

        It "passes Uri plus query to Invoke-RestMethod correctly" {
            $result.Uri | Should -Be "$uri/$simplePath`?prop1=val1"
        }
    }
}