using module ..\..\..\PowerJira\classes\HashtableUtility.psm1
using module ..\..\..\PowerJira\classes\JiraContext.psm1
using module ..\..\..\PowerJira\classes\PowerJiraGlobal.psm1
using module ..\..\..\PowerJira\classes\RestMethod\RestMethod.psm1
using module ..\..\..\PowerJira\classes\RestMethod\RestMethodQueryParams.psm1

. $PSScriptRoot\..\..\mocks\Mock-InvokeRestMethod.ps1

Describe "RestMethod (Class)" {
    $simplePath = "path"
    $get = "GET"
    $defaultContentType = "application/json"

    Context "No Query String Constructor" {
        It "no query constructor sets FunctionPath and HttpMethod" {
            $rm = New-Object RestMethod $($simplePath,$get)

            $rm.FunctionPath | Should -Be $simplePath
            $rm.HttpMethod | Should -Be $get
        }
        It "no query constructor initializes Headers and ContentType" {
            $rm = New-Object RestMethod $($simplePath,$get)

            $rm.Headers | Should -Not -Be $null
            $rm.Headers | Should -BeNullOrEmpty
            $rm.ContentType | Should -Be $defaultContentType
        }
        It "no query constructor should trim leading slashes from FunctionPath" {
            $rm = New-Object RestMethod $("/$simplePath",$get)

            $rm.FunctionPath | Should -Be $simplePath
        }
        It "no query constructor should validate blank FunctionPath" {
            { $rm = New-Object RestMethod $("",$get) } | Should -Throw
        }
        It "no query constructor should validate HttpVerb" {
            { $rm = New-Object RestMethod $($simplePath,"JOUST") } | Should -Throw
        }
    }
    Context "Query String Constructor" {
        $qs = New-Object RestMethodQueryParams @{
            prop1 = "val1"
            prop2 = "val2"
        }

        It "qs constructor sets FunctionPath, HttpMethod, and the query params" {
            $rm = New-Object RestMethod @($simplePath,$get,$qs)

            $rm.FunctionPath | Should -Be $simplePath
            $rm.HttpMethod | Should -Be $get
            $rm.Query | Should -Be $qs
        }
        It "no query constructor initializes Headers and ContentType" {
            $rm = New-Object RestMethod $($simplePath,$get,$qs)

            $rm.Headers | Should -Not -Be $null
            $rm.Headers | Should -BeNullOrEmpty
            $rm.ContentType | Should -Be $defaultContentType
        }
        It "qs constructor should trim leading slashes from FunctionPath" {
            $rm = New-Object RestMethod $("/$simplePath",$get,$qs)

            $rm.FunctionPath | Should -Be $simplePath
        }
        It "qs constructor should validate blank FunctionPath" {
            { $rm = New-Object RestMethod $("",$get,$qs) } | Should -Throw
        }
        It "qs constructor should validate HttpVerb" {
            { $rm = New-Object RestMethod $($simplePath,"JOUST",$qs) } | Should -Throw
        }
    }
    Context "FillContext Static Method" {
        $jc = New-Object JiraContext @("1","2","3")
        $jc2 = New-Object JiraContext @("2","3","4")
        $Global:PowerJira = New-Object PowerJiraGlobal
        $Global:PowerJira.Context = $jc2

        It "returns the JiraContext object it is given" {
            [RestMethod]::FillContext($jc) | Should -Be $jc
        }
        It "returns the global context if null is provided" {
            [RestMethod]::FillContext($null) | Should -Be $jc2
        }
        It "throws an error if null is provided and no global context is set" {
            $Global:PowerJira = $null
            { [RestMethod]::FillContext($null) } | Should -Throw
        }

        $Global:PowerJira = $null
    }
    Context "Uri Method" {
        $uri = "https://my-uri.com"
        $jc = New-Object JiraContext @("1","2",$uri)
        $qs = New-Object RestMethodQueryParams @{
            prop1 = "val1"
        }

        It "returns the correct path with no query params" {
            $rm = New-Object RestMethod @($simplePath,$get)

            $rm.Uri($jc) | Should -Be "$uri/$simplePath"
        }
        It "returns the correct path with query params" {
            $rm = New-Object RestMethod @($simplePath,$get,$qs)

            $rm.Uri($jc) | Should -Be "$uri/$simplePath`?prop1=val1"
        }
    }
    Context "HeadersToSend Method" {
        $uri = "https://my-uri.com"
        $jc = New-Object JiraContext @("1","2",$uri)

        It "adds the Auth header from the context object to the RestMethod headers" {
            $newHeader = @{
                "X-ATTR-FAKE-HEADER" = "this isn't real"
            }
            $rm = New-Object RestMethod @($simplePath,$get)
            $rm.Headers += $newHeader
            $compiledHeaders = $newHeader + $jc.AuthHeader

            [HashtableUtility]::Compare($compiledHeaders,$rm.HeadersToSend($jc)) | Should -BeNullOrEmpty
        }
    }
    Context "Invoke Method (no query)" {
        $uri = "https://my-uri.com"
        $retries = 3
        $delay = 5
        $jc = New-Object JiraContext @("1","2",$uri,$retries,$delay)
        Mock "Invoke-RestMethod" $MockInvokeRestMethod -ModuleName RestMethod
        $rm = New-Object RestMethod @($simplePath,$get)
        $result = $rm.Invoke($jc)

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
        It "passes MaximumRetryCount to Invoke-RestMethod correctly" {
            $result.MaximumRetryCount | Should -Be $retries
        }
        It "passes RetryIntervalSec to Invoke-RestMethod correctly" {
            $result.RetryIntervalSec | Should -Be $delay
        }
    }
    Context "Invoke Method (with query)" {
        $uri = "https://my-uri.com"
        $jc = New-Object JiraContext @("1","2",$uri)
        $qs = New-Object RestMethodQueryParams @{
            prop1 = "val1"
        }
        Mock "Invoke-RestMethod" $MockInvokeRestMethod -ModuleName RestMethod
        $rm = New-Object RestMethod @($simplePath,$get,$qs)
        $result = $rm.Invoke($jc)

        It "passes Uri plus query to Invoke-RestMethod correctly" {
            $result.Uri | Should -Be "$uri/$simplePath`?prop1=val1"
        }
    }
    Context "Invoke-RestMethod error handling" {
        $uri = "https://my-uri.com"
        $retries = 3
        $delay = 1
        $jc = New-Object JiraContext @("1","2",$uri, $retries, $delay)
        Mock "Start-Sleep" {} -ModuleName RestMethod

        It "retries the correct number of times when an exception is thrown" {
            Mock "Invoke-RestMethod" { throw [System.Net.Http.HttpRequestException]::new() } -ModuleName RestMethod
            $rm = New-Object RestMethod @($simplePath,$get)
            { $rm.Invoke($jc) } | Should -Throw
            { Assert-MockCalled "Invoke-RestMethod" -Times ($retries + 1) -Exactly -ModuleName RestMethod -Scope "It" } | Should -Not -Throw
        }
        It "sleeps each time an exception is thrown" {
            Mock "Invoke-RestMethod" { throw [System.Net.Http.HttpRequestException]::new() } -ModuleName RestMethod
            $rm = New-Object RestMethod @($simplePath,$get)
            { $rm.Invoke($jc) } | Should -Throw
            { Assert-MockCalled "Start-Sleep" -Times ($retries) -Exactly -ModuleName RestMethod -Scope "It" } | Should -Not -Throw
        }
        It "sleeps for the correct duration" {
            Mock "Invoke-RestMethod" { throw [System.Net.Http.HttpRequestException]::new() } -ModuleName RestMethod
            $rm = New-Object RestMethod @($simplePath,$get)
            { $rm.Invoke($jc) } | Should -Throw
            { Assert-MockCalled "Start-Sleep" -ParameterFilter {$Seconds -and $Seconds -eq $delay} -ModuleName RestMethod -Scope "It" } | Should -Not -Throw
        }
        It "succeeds after an intial error" {
            $oneError = {
                Mock "Invoke-RestMethod" {return @{}} -ModuleName RestMethod
                throw [System.Net.Http.HttpRequestException]::new()
            }
            Mock "Invoke-RestMethod" $oneError -ModuleName RestMethod
            $rm = New-Object RestMethod @($simplePath,$get)
            { $rm.Invoke($jc) } | Should -Not -Throw
            { Assert-MockCalled "Invoke-RestMethod" -Times 2 -Exactly -ModuleName RestMethod -Scope "It" } | Should -Not -Throw
        }
    }
}