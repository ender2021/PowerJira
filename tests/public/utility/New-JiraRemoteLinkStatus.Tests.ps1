Describe "New-JiraRemoteLinkStatus" {
    Context "-Icon validation" {
        It "accepts -Icon with only the two required properties" {
            {
                New-JiraRemoteLinkStatus @{url16x16 = "https://somesite.com/image.jpg"
                                           title = "some icon"}
            } | Should -Not -Throw
        }
        It "accepts -Icon with all three properties" {
            {
                New-JiraRemoteLinkStatus @{url16x16 = "https://somesite.com/image.jpg"
                                           title = "some icon"
                                           link = "https://somesite.com/tooltip.txt"}
            } | Should -Not -Throw
        }
        It "accepts -Icon with extra properties" {
            {
                New-JiraRemoteLinkStatus @{url16x16 = "https://somesite.com/image.jpg"
                                           title = "some icon"
                                           link = "https://somesite.com/tooltip.txt"
                                           aNewProp = "some value"}
            } | Should -Not -Throw
        }
    }
    Context "properties exist" {
        It "returns an object with property icon (if one is set)" {
            $obj = New-JiraRemoteLinkStatus @{url16x16 = "https://somesite.com/image.jpg"; title = "some icon"}
            $obj.Keys | Should -Contain "icon"
        }

        It "returns an object with property resolved" {
            $obj = New-JiraRemoteLinkStatus @{url16x16 = "https://somesite.com/image.jpg"; title = "some icon"}
            $obj.Keys | Should -Contain "resolved"
        }
    }
    Context "default values" {
        It "defaults resolved to false" {
            $obj = New-JiraRemoteLinkStatus @{url16x16 = "https://somesite.com/image.jpg"; title = "some icon"}
            $obj.resolved | Should -BeFalse
        }
    }
    Context "properties set correctly" {
        It "sets resolved to true if -Resolved is set" {
            $obj = New-JiraRemoteLinkStatus @{url16x16 = "https://somesite.com/image.jpg"; title = "some icon"} -Resolved
            $obj.resolved | Should -BeTrue            
        }
    }
}