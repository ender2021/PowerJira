. $PSScriptRoot\..\mocks\Mock-InvokeRestMethod.ps1
. $PSScriptRoot\..\mocks\Mock-NewJiraConnection.ps1

$InvokeJiraRestRequest_ContentType = "application/json"

Describe "Invoke-JiraRestRequest" {
    Context "Missing/Malformed JiraConnection Object" {
        It "throws 'Missing/Malformed JiraConnection' when connection is not supplied and no session is open" {
            Mock "Invoke-RestMethod" $MockInvokeRestMethod
            { Invoke-JiraRestRequest $null "some/path" "GET" } | Should -Throw 'Missing/Malformed JiraConnection'
        }
        It 'throws validation error when the JiraConnection object is missing required keys' {
            Mock "Invoke-RestMethod" $MockInvokeRestMethod
            { Invoke-JiraRestRequest @{AuthHeader=@{}} "some/path" "GET" } | Should -Throw 'Missing/Malformed JiraConnection'
        }
    }
    Context "AuthHeader" {
        It "created the Authorization key in the Headers parameter" {
            Mock "New-JiraConnection" $MockNewJiraConnection
            Mock "Invoke-RestMethod" $MockInvokeRestMethod
            $conn = New-JiraConnection dummy dummy dummy
            $path = "some/path"
            $req = Invoke-JiraRestRequest $conn $path "GET"
            $req.Headers.Keys | Should -Contain "Authorization"
        }
        It "set the value of the Authorization key in the Headers parameter" {
            Mock "New-JiraConnection" $MockNewJiraConnection
            Mock "Invoke-RestMethod" $MockInvokeRestMethod
            $conn = New-JiraConnection dummy dummy dummy
            $path = "some/path"
            $req = Invoke-JiraRestRequest $conn $path "GET"
            $req.Headers.Authorization | Should -Be $conn.AuthHeader.Authorization
        }
    }
    Context "ContentType" {
        It "sets ContentType for bodyless requests" {
            Mock "New-JiraConnection" $MockNewJiraConnection
            Mock "Invoke-RestMethod" $MockInvokeRestMethod
            $conn = New-JiraConnection dummy dummy dummy
            $path = "some/path"
            $req = Invoke-JiraRestRequest $conn $path "GET"
            $req.ContentType | Should -Be $InvokeJiraRestRequest_ContentType
        }
        It "sets ContentType for query requests" {
            Mock "New-JiraConnection" $MockNewJiraConnection
            Mock "Invoke-RestMethod" $MockInvokeRestMethod
            $conn = New-JiraConnection dummy dummy dummy
            $path = "some/path"
            $req = Invoke-JiraRestRequest $conn $path "GET" -Query @{some="content"}
            $req.ContentType | Should -Be $InvokeJiraRestRequest_ContentType
        }
        It "sets ContentType for Json Body requests" {
            Mock "New-JiraConnection" $MockNewJiraConnection
            Mock "Invoke-RestMethod" $MockInvokeRestMethod
            $conn = New-JiraConnection dummy dummy dummy
            $path = "some/path"
            $req = Invoke-JiraRestRequest $conn $path "POST" -Body @{some="content"}
            $req.ContentType | Should -Be $InvokeJiraRestRequest_ContentType
        }
        It "sets ContentType for Simple Body requests" {
            Mock "New-JiraConnection" $MockNewJiraConnection
            Mock "Invoke-RestMethod" $MockInvokeRestMethod
            $conn = New-JiraConnection dummy dummy dummy
            $path = "some/path"
            $req = Invoke-JiraRestRequest $conn $path "POST" -LiteralBody '{"some"="content"}'
            $req.ContentType | Should -Be $InvokeJiraRestRequest_ContentType
        }
        It "does not set ContentType for Form requests" {
            Mock "New-JiraConnection" $MockNewJiraConnection
            Mock "Invoke-RestMethod" $MockInvokeRestMethod
            $conn = New-JiraConnection dummy dummy dummy
            $path = "some/path"
            $req = Invoke-JiraRestRequest $conn $path "POST" -Form @{some="content"}
            $req.ContentType | Should -BeNullOrEmpty
        }
    }
    Context "HttpMethod" {
        It "sets HttpMethod correctly" {
            Mock "New-JiraConnection" $MockNewJiraConnection
            Mock "Invoke-RestMethod" $MockInvokeRestMethod
            $conn = New-JiraConnection dummy dummy dummy
            $path = "some/path"
            $verb = "GET"
            $req = Invoke-JiraRestRequest $conn $path $verb
            $req.Method | Should -Be $verb
        }
        It "does not allow unapproved HTTP verbs" {
            Mock "New-JiraConnection" $MockNewJiraConnection
            Mock "Invoke-RestMethod" $MockInvokeRestMethod
            $conn = New-JiraConnection dummy dummy dummy
            $path = "some/path"
            $verb = "BURP"
            {Invoke-JiraRestRequest $conn $path $verb} | Should -Throw "validate"
        }
    }
    Context "GET/DELETE body validation" {
        It "does not allow -Body when using 'GET'" {
            Mock "New-JiraConnection" $MockNewJiraConnection
            Mock "Invoke-RestMethod" $MockInvokeRestMethod
            $conn = New-JiraConnection dummy dummy dummy
            $path = "some/path"
            $verb = "GET"
            {Invoke-JiraRestRequest $conn $path $verb -Body @{some="content"}} | Should -Throw "Invalid HttpMethod / Parameter combination"
        }
        It "does not allow -Body when using 'DELETE'" {
            Mock "New-JiraConnection" $MockNewJiraConnection
            Mock "Invoke-RestMethod" $MockInvokeRestMethod
            $conn = New-JiraConnection dummy dummy dummy
            $path = "some/path"
            $verb = "DELETE"
            {Invoke-JiraRestRequest $conn $path $verb -Body @{some="content"}} | Should -Throw "Invalid HttpMethod / Parameter combination"
        }
        It "does not allow -LiteralBody when using 'GET'" {
            Mock "New-JiraConnection" $MockNewJiraConnection
            Mock "Invoke-RestMethod" $MockInvokeRestMethod
            $conn = New-JiraConnection dummy dummy dummy
            $path = "some/path"
            $verb = "GET"
            {Invoke-JiraRestRequest $conn $path $verb -LiteralBody '{"some"="content"}'} | Should -Throw "Invalid HttpMethod / Parameter combination"
        }
        It "does not allow -LiteralBody when using 'DELETE'" {
            Mock "New-JiraConnection" $MockNewJiraConnection
            Mock "Invoke-RestMethod" $MockInvokeRestMethod
            $conn = New-JiraConnection dummy dummy dummy
            $path = "some/path"
            $verb = "DELETE"
            {Invoke-JiraRestRequest $conn $path $verb -LiteralBody '{"some"="content"}'} | Should -Throw "Invalid HttpMethod / Parameter combination"
        }
        It "does not allow -Form when using 'GET'" {
            Mock "New-JiraConnection" $MockNewJiraConnection
            Mock "Invoke-RestMethod" $MockInvokeRestMethod
            $conn = New-JiraConnection dummy dummy dummy
            $path = "some/path"
            $verb = "GET"
            {Invoke-JiraRestRequest $conn $path $verb -Form @{some="content"}} | Should -Throw "Invalid HttpMethod / Parameter combination"
        }
        It "does not allow -BodyKvp when using 'DELETE'" {
            Mock "New-JiraConnection" $MockNewJiraConnection
            Mock "Invoke-RestMethod" $MockInvokeRestMethod
            $conn = New-JiraConnection dummy dummy dummy
            $path = "some/path"
            $verb = "DELETE"
            {Invoke-JiraRestRequest $conn $path $verb -Form @{some="content"}} | Should -Throw "Invalid HttpMethod / Parameter combination"
        }
    }
    Context "POST/PUT/PATCH body validation" {
        It "does not allow 'POST' without a body or form parameter" {
            Mock "New-JiraConnection" $MockNewJiraConnection
            Mock "Invoke-RestMethod" $MockInvokeRestMethod
            $conn = New-JiraConnection dummy dummy dummy
            $path = "some/path"
            $verb = "POST"
            {Invoke-JiraRestRequest $conn $path $verb} | Should -Throw "Invalid HttpMethod / Parameter combination"
        }
        It "does not allow 'PUT' without a body or form parameter" {
            Mock "New-JiraConnection" $MockNewJiraConnection
            Mock "Invoke-RestMethod" $MockInvokeRestMethod
            $conn = New-JiraConnection dummy dummy dummy
            $path = "some/path"
            $verb = "PUT"
            {Invoke-JiraRestRequest $conn $path $verb} | Should -Throw "Invalid HttpMethod / Parameter combination"
        }
        It "does not allow 'PATCH' without a body or form parameter" {
            Mock "New-JiraConnection" $MockNewJiraConnection
            Mock "Invoke-RestMethod" $MockInvokeRestMethod
            $conn = New-JiraConnection dummy dummy dummy
            $path = "some/path"
            $verb = "PATCH"
            {Invoke-JiraRestRequest $conn $path $verb} | Should -Throw "Invalid HttpMethod / Parameter combination"
        }
        It "allows 'POST' with -Body" {
            Mock "New-JiraConnection" $MockNewJiraConnection
            Mock "Invoke-RestMethod" $MockInvokeRestMethod
            $conn = New-JiraConnection dummy dummy dummy
            $path = "some/path"
            $verb = "POST"
            $req = Invoke-JiraRestRequest $conn $path $verb -Body @{some="Content"}
            $req.Method | Should -Be $verb
        }
        It "allows 'PUT' with -Body" {
            Mock "New-JiraConnection" $MockNewJiraConnection
            Mock "Invoke-RestMethod" $MockInvokeRestMethod
            $conn = New-JiraConnection dummy dummy dummy
            $path = "some/path"
            $verb = "PUT"
            $req = Invoke-JiraRestRequest $conn $path $verb -Body @{some="Content"}
            $req.Method | Should -Be $verb
        }
        It "allows 'PATCH' with -Body" {
            Mock "New-JiraConnection" $MockNewJiraConnection
            Mock "Invoke-RestMethod" $MockInvokeRestMethod
            $conn = New-JiraConnection dummy dummy dummy
            $path = "some/path"
            $verb = "PATCH"
            $req = Invoke-JiraRestRequest $conn $path $verb -Body @{some="Content"}
            $req.Method | Should -Be $verb
        }
        It "allows 'POST' with -LiteralBody" {
            Mock "New-JiraConnection" $MockNewJiraConnection
            Mock "Invoke-RestMethod" $MockInvokeRestMethod
            $conn = New-JiraConnection dummy dummy dummy
            $path = "some/path"
            $verb = "POST"
            $req = Invoke-JiraRestRequest $conn $path $verb -LiteralBody '{"some"="content"}'
            $req.Method | Should -Be $verb
        }
        It "allows 'PUT' with -LiteralBody" {
            Mock "New-JiraConnection" $MockNewJiraConnection
            Mock "Invoke-RestMethod" $MockInvokeRestMethod
            $conn = New-JiraConnection dummy dummy dummy
            $path = "some/path"
            $verb = "PUT"
            $req = Invoke-JiraRestRequest $conn $path $verb -LiteralBody '{"some"="content"}'
            $req.Method | Should -Be $verb
        }
        It "allows 'PATCH' with -LiteralBody" {
            Mock "New-JiraConnection" $MockNewJiraConnection
            Mock "Invoke-RestMethod" $MockInvokeRestMethod
            $conn = New-JiraConnection dummy dummy dummy
            $path = "some/path"
            $verb = "PATCH"
            $req = Invoke-JiraRestRequest $conn $path $verb -LiteralBody '{"some"="content"}'
            $req.Method | Should -Be $verb
        }
        It "allows 'POST' with -Form" {
            Mock "New-JiraConnection" $MockNewJiraConnection
            Mock "Invoke-RestMethod" $MockInvokeRestMethod
            $conn = New-JiraConnection dummy dummy dummy
            $path = "some/path"
            $verb = "POST"
            $req = Invoke-JiraRestRequest $conn $path $verb -Form @{some="Content"}
            $req.Method | Should -Be $verb
        }
        It "allows 'PUT' with -Form" {
            Mock "New-JiraConnection" $MockNewJiraConnection
            Mock "Invoke-RestMethod" $MockInvokeRestMethod
            $conn = New-JiraConnection dummy dummy dummy
            $path = "some/path"
            $verb = "PUT"
            $req = Invoke-JiraRestRequest $conn $path $verb -Form @{some="Content"}
            $req.Method | Should -Be $verb
        }
        It "allows 'PATCH' with -Form" {
            Mock "New-JiraConnection" $MockNewJiraConnection
            Mock "Invoke-RestMethod" $MockInvokeRestMethod
            $conn = New-JiraConnection dummy dummy dummy
            $path = "some/path"
            $verb = "PATCH"
            $req = Invoke-JiraRestRequest $conn $path $verb -Form @{some="Content"}
            $req.Method | Should -Be $verb
        }
    }
    Context "GET functions" {
        It "GET with no query" {
            Mock "New-JiraConnection" $MockNewJiraConnection
            Mock "Invoke-RestMethod" $MockInvokeRestMethod
            $conn = New-JiraConnection dummy dummy dummy
            $path = "some/path"
            $verb = "GET"
            $contentType = "application/json"
            $req = Invoke-JiraRestRequest $conn $path $verb
            $req.Uri | Should -Be ($conn.HostName + $path)
            $req.Method | Should -Be $verb
            $req.Headers.Keys | Should -Contain "Authorization"
            $req.Headers.Authorization | Should -Be $conn.AuthHeader.Authorization
            $req.Body | Should -BeNullOrEmpty
            $req.Form | Should -BeNullOrEmpty
        }
        It "GET with one query param as hash" {
            Mock "New-JiraConnection" $MockNewJiraConnection
            Mock "Invoke-RestMethod" $MockInvokeRestMethod
            $conn = New-JiraConnection dummy dummy dummy
            $path = "some/path"
            $verb = "GET"
            $contentType = "application/json"
            $query = @{one="param"}
            $req = Invoke-JiraRestRequest $conn $path $verb -Query $query
            $req.Uri | Should -Be ($conn.HostName + $path + '?' + "one=param")
            $req.Method | Should -Be $verb
            $req.Headers.Keys | Should -Contain "Authorization"
            $req.Headers.Authorization | Should -Be $conn.AuthHeader.Authorization
            $req.ContentType | Should -Be $contentType
            $req.Body | Should -BeNullOrEmpty
            $req.Form | Should -BeNullOrEmpty
        }
        It "GET with multiple query params as hash" {
            Mock "New-JiraConnection" $MockNewJiraConnection
            Mock "Invoke-RestMethod" $MockInvokeRestMethod
            $conn = New-JiraConnection dummy dummy dummy
            $path = "some/path"
            $verb = "GET"
            $contentType = "application/json"
            $query = @{one="param";two="items"}
            $expectedPath = $conn.HostName + $path
            $expectedQueries = @($expectedPath + '?' + "one=param&two=items";$expectedPath + '?' + "two=items&one=param")
            $req = Invoke-JiraRestRequest $conn $path $verb -Query $query
            $req.Uri | Should -BeIn $expectedQueries
            $req.Method | Should -Be $verb
            $req.Headers.Keys | Should -Contain "Authorization"
            $req.Headers.Authorization | Should -Be $conn.AuthHeader.Authorization
            $req.ContentType | Should -Be $contentType
            $req.Body | Should -BeNullOrEmpty
            $req.Form | Should -BeNullOrEmpty
        }
    }
    # Context "POST functions" {
        
    # }
    # Context "PUT functions" {

    # }
    # Context "DELETE functions" {

    # }
}