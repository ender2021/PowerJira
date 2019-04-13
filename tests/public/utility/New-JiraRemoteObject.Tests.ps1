Describe "New-JiraRemoteObject" {
    Context "-Icon validation" {
        It "accepts -Icon with only the two required properties" {
            {
                $icon = @{
                    url16x16 = "https://somesite.com/image.jpg"
                    title = "some icon"
                }
                New-JiraRemoteObject "https://somesite.com/remote-item/3/" "Remote Item 3" -Icon $icon
            } | Should -Not -Throw
        }
        It "accepts -Icon with all three properties" {
            {
                $icon = @{
                    url16x16 = "https://somesite.com/image.jpg"
                    title = "some icon"
                    link = "https://somesite.com/tooltip.txt"
                }
                New-JiraRemoteObject "https://somesite.com/remote-item/3/" "Remote Item 3" -Icon $icon
            } | Should -Not -Throw
        }
        It "accepts -Icon with extra properties" {
            {
                $icon = @{
                    url16x16 = "https://somesite.com/image.jpg"
                    title = "some icon"
                    link = "https://somesite.com/tooltip.txt"
                    aNewProp = "some value"
                }
                New-JiraRemoteObject "https://somesite.com/remote-item/3/" "Remote Item 3" -Icon $icon
            } | Should -Not -Throw
        }
    }
    Context "properties exist" {
        It "returns an object with property url" {
            $obj = New-JiraRemoteObject "https://somesite.com/remote-item/3/" "Remote Item 3"
            $obj.Keys | Should -Contain "url"
        }
        It "returns an object with property title" {
            $obj = New-JiraRemoteObject "https://somesite.com/remote-item/3/" "Remote Item 3"
            $obj.Keys | Should -Contain "title"
        }
        It "returns an object with property summary (if one is set)" {
            $obj = New-JiraRemoteObject "https://somesite.com/remote-item/3/" "Remote Item 3" -Summary "remote object summary"
            $obj.Keys | Should -Contain "summary"
        }
        It "returns an object with property icon (if one is set)" {
            $icon = @{
                url16x16 = "https://somesite.com/image.jpg"
                title = "some icon"
            }
            $obj = New-JiraRemoteObject "https://somesite.com/remote-item/3/" "Remote Item 3" -Icon $icon
            $obj.Keys | Should -Contain "icon"
        }
        It "returns an object with property status" {
            $obj = New-JiraRemoteObject "https://somesite.com/remote-item/3/" "Remote Item 3" -Status @{}
            $obj.Keys | Should -Contain "status"
        }
    }
    Context "properties set correctly" {
        It "sets property url correctly" {
            $url = "https://somesite.com/remote-item/3/"
            $obj = New-JiraRemoteObject $url "Remote Item 3"
            $obj.url | Should -Be $url
        }
        It "sets property title correctly" {
            $title = "Remote Item 3"
            $obj = New-JiraRemoteObject "https://somesite.com/remote-item/3/" $title
            $obj.title | Should -Be $title
        }
        It "sets property summary correctly" {
            $summary = "remote object summary"
            $obj = New-JiraRemoteObject "https://somesite.com/remote-item/3/" "Remote Item 3" -Summary $summary
            $obj.summary | Should -Be $summary
        }
    }
}