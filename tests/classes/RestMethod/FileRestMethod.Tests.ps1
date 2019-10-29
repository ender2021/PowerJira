using module ..\..\..\PowerJira\classes\JiraContext.psm1
using module ..\..\..\PowerJira\classes\PowerJiraGlobal.psm1
using module ..\..\..\PowerJira\classes\RestMethod\FileRestMethod.psm1
using module ..\..\..\PowerJira\classes\RestMethod\RestMethodQueryParams.psm1

. ..\..\..\PowerJira\private\Compare-Hashtable.ps1
. ..\..\mocks\Mock-InvokeRestMethod.ps1

Describe "FileRestMethod (Class)" {
    $simplePath = "path"
    $get = "GET"
    $defaultContentType = "application/json"
    $filePath = "D:\my\file\path.txt"
    $xAtlasToken = @{
        "X-Atlassian-Token" = "no-check"
    }

    Context "No Query String Constructor" {
        It "no query constructor sets FunctionPath and HttpMethod" {
            $rm = New-Object FileRestMethod $($simplePath,$get,$filePath)

            $rm.FunctionPath | Should -Be $simplePath
            $rm.HttpMethod | Should -Be $get
            $rm.FilePath | Should -Be $filePath
        }
        It "no query constructor initializes Headers with the X-Atlassian-Token header" {
            $rm = New-Object FileRestMethod $($simplePath,$get,$filePath)
            
            Compare-Hashtable $rm.Headers $xAtlasToken | Should -BeNullOrEmpty
        }
        It "no query constructor initializes ContentType" {
            $rm = New-Object FileRestMethod $($simplePath,$get,$filePath)

            $rm.ContentType | Should -Be $defaultContentType
        }
        It "no query constructor should trim leading slashes from FunctionPath" {
            $rm = New-Object FileRestMethod $("/$simplePath",$get,$filePath)

            $rm.FunctionPath | Should -Be $simplePath
        }
        It "no query constructor should validate blank FunctionPath" {
            { $rm = New-Object FileRestMethod $("",$get,$filePath) } | Should -Throw
        }
        It "no query constructor should validate HttpVerb" {
            { $rm = New-Object FileRestMethod $($simplePath,"JOUST",$filePath) } | Should -Throw
        }
    }
    Context "Query String Constructor" {
        $qs = New-Object RestMethodQueryParams @{
            prop1 = "val1"
            prop2 = "val2"
        }

        It "qs constructor sets FunctionPath, HttpMethod, and the query params" {
            $rm = New-Object FileRestMethod @($simplePath,$get,$qs,$filePath)

            $rm.FunctionPath | Should -Be $simplePath
            $rm.HttpMethod | Should -Be $get
            $rm.FilePath | Should -Be $filePath
            $rm.Query | Should -Be $qs
        }
        It "qs query constructor initializes Headers with the X-Atlassian-Token header" {
            $rm = New-Object FileRestMethod $($simplePath,$get,$qs,$filePath)            

            Compare-Hashtable $rm.Headers $xAtlasToken | Should -BeNullOrEmpty
        }
        It "qs query constructor initializes ContentType" {
            $rm = New-Object FileRestMethod $($simplePath,$get,$qs,$filePath)

            $rm.ContentType | Should -Be $defaultContentType
        }
        It "qs constructor should trim leading slashes from FunctionPath" {
            $rm = New-Object FileRestMethod $("/$simplePath",$get,$qs,$filePath)

            $rm.FunctionPath | Should -Be $simplePath
        }
        It "qs constructor should validate blank FunctionPath" {
            { $rm = New-Object FileRestMethod $("",$get,$qs,$filePath) } | Should -Throw
        }
        It "qs constructor should validate HttpVerb" {
            { $rm = New-Object FileRestMethod $($simplePath,"JOUST",$qs,$filePath) } | Should -Throw
        }
    }
    Context "Invoke Method (no query)" {
        $uri = "https://my-uri.com"
        $jc = New-Object JiraContext @("1","2",$uri)
        Mock "Invoke-RestMethod" $MockInvokeRestMethod
        $rm = New-Object FileRestMethod @($simplePath,$get,$filePath)
        $result = $rm.Invoke($jc)

        It "passes Uri to Invoke-RestMethod correctly" {
            $result.Uri | Should -Be "$uri/$simplePath"
        }
        It "passes Method to Invoke-RestMethod correctly" {
            $result.Method | Should -Be $get
        }
        It "passes Headers to Invoke-RestMethod correctly" {
            $expectedHeaders = $jc.AuthHeader + $xAtlasToken
            Compare-Hashtable $result.Headers $expectedHeaders | Should -BeNullOrEmpty
        }
        It "passes InFile to Invoke-RestMethod correctly" {
            $result.InFile | Should -Be $filePath
        }
    }
    Context "Invoke Method (with query)" {
        $uri = "https://my-uri.com"
        $jc = New-Object JiraContext @("1","2",$uri)
        $qs = New-Object RestMethodQueryParams @{
            prop1 = "val1"
        }
        Mock "Invoke-RestMethod" $MockInvokeRestMethod
        $rm = New-Object FileRestMethod @($simplePath,$get,$qs,$filePath)
        $result = $rm.Invoke($jc)

        It "passes Uri plus query to Invoke-RestMethod correctly" {
            $result.Uri | Should -Be "$uri/$simplePath`?prop1=val1"
        }
    }
}