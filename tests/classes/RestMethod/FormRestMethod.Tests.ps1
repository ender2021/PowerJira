using module ..\..\..\PowerJira\classes\HashtableUtility.psm1
using module ..\..\..\PowerJira\classes\JiraContext.psm1
using module ..\..\..\PowerJira\classes\PowerJiraGlobal.psm1
using module ..\..\..\PowerJira\classes\RestMethod\FormRestMethod.psm1
using module ..\..\..\PowerJira\classes\RestMethod\RestMethodQueryParams.psm1

. $PSScriptRoot\..\..\mocks\Mock-InvokeRestMethod.ps1

Describe "FormRestMethod (Class)" {
    $simplePath = "path"
    $get = "GET"
    $defaultContentType = "application/json"
    $formHash = @{form="someValue"}
    $xAtlasToken = @{
        "X-Atlassian-Token" = "no-check"
    }

    Context "No Query String Constructor" {
        It "no query constructor sets FunctionPath and HttpMethod" {
            $rm = New-Object FormRestMethod $($simplePath,$get,$formHash)

            $rm.FunctionPath | Should -Be $simplePath
            $rm.HttpMethod | Should -Be $get
            [HashtableUtility]::Compare($rm.Form,$formHash) | Should -BeNullOrEmpty
        }
        It "no query constructor initializes Headers with the X-Atlassian-Token header" {
            $rm = New-Object FormRestMethod $($simplePath,$get,$formHash)
            
            [HashtableUtility]::Compare($rm.Headers,$xAtlasToken) | Should -BeNullOrEmpty
        }
        It "no query constructor initializes ContentType" {
            $rm = New-Object FormRestMethod $($simplePath,$get,$formHash)

            $rm.ContentType | Should -Be $defaultContentType
        }
        It "no query constructor should trim leading slashes from FunctionPath" {
            $rm = New-Object FormRestMethod $("/$simplePath",$get,$formHash)

            $rm.FunctionPath | Should -Be $simplePath
        }
        It "no query constructor should validate blank FunctionPath" {
            { $rm = New-Object FormRestMethod $("",$get,$formHash) } | Should -Throw
        }
        It "no query constructor should validate HttpVerb" {
            { $rm = New-Object FormRestMethod $($simplePath,"JOUST",$formHash) } | Should -Throw
        }
    }
    Context "Query String Constructor" {
        $qs = New-Object RestMethodQueryParams @{
            prop1 = "val1"
            prop2 = "val2"
        }

        It "qs constructor sets FunctionPath, HttpMethod, and the query params" {
            $rm = New-Object FormRestMethod @($simplePath,$get,$qs,$formHash)

            $rm.FunctionPath | Should -Be $simplePath
            $rm.HttpMethod | Should -Be $get
            [HashtableUtility]::Compare($rm.Form,$formHash) | Should -BeNullOrEmpty
            $rm.Query | Should -Be $qs
        }
        It "qs query constructor initializes Headers with the X-Atlassian-Token header" {
            $rm = New-Object FormRestMethod $($simplePath,$get,$qs,$formHash)            

            [HashtableUtility]::Compare($rm.Headers,$xAtlasToken) | Should -BeNullOrEmpty
        }
        It "qs query constructor initializes ContentType" {
            $rm = New-Object FormRestMethod $($simplePath,$get,$qs,$formHash)

            $rm.ContentType | Should -Be $defaultContentType
        }
        It "qs constructor should trim leading slashes from FunctionPath" {
            $rm = New-Object FormRestMethod $("/$simplePath",$get,$qs,$formHash)

            $rm.FunctionPath | Should -Be $simplePath
        }
        It "qs constructor should validate blank FunctionPath" {
            { $rm = New-Object FormRestMethod $("",$get,$qs,$formHash) } | Should -Throw
        }
        It "qs constructor should validate HttpVerb" {
            { $rm = New-Object FormRestMethod $($simplePath,"JOUST",$qs,$formHash) } | Should -Throw
        }
    }
    Context "Invoke Method (no query)" {
        $uri = "https://my-uri.com"
        $jc = New-Object JiraContext @("1","2",$uri)
        Mock "Invoke-RestMethod" $MockInvokeRestMethod -ModuleName FormRestMethod
        $rm = New-Object FormRestMethod @($simplePath,$get,$formHash)
        $result = $rm.Invoke($jc)

        It "passes Uri to Invoke-RestMethod correctly" {
            $result.Uri | Should -Be "$uri/$simplePath"
        }
        It "passes Method to Invoke-RestMethod correctly" {
            $result.Method | Should -Be $get
        }
        It "passes Headers to Invoke-RestMethod correctly" {
            $expectedHeaders = $jc.AuthHeader + $xAtlasToken
            [HashtableUtility]::Compare($result.Headers,$expectedHeaders) | Should -BeNullOrEmpty
        }
        It "passes Form to Invoke-RestMethod correctly" {
            [HashtableUtility]::Compare($result.Form,$formHash) | Should -BeNullOrEmpty
        }
    }
    Context "Invoke Method (with query)" {
        $uri = "https://my-uri.com"
        $jc = New-Object JiraContext @("1","2",$uri)
        $qs = New-Object RestMethodQueryParams @{
            prop1 = "val1"
        }
        Mock "Invoke-RestMethod" $MockInvokeRestMethod -ModuleName FormRestMethod
        $rm = New-Object FormRestMethod @($simplePath,$get,$qs,$formHash)
        $result = $rm.Invoke($jc)

        It "passes Uri plus query to Invoke-RestMethod correctly" {
            $result.Uri | Should -Be "$uri/$simplePath`?prop1=val1"
        }
    }
}