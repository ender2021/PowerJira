Describe "New-JiraRemoteLinkIcon" {
    Context "properties exist" {
        It "returns an object with property 'url16x16'" {
            $obj = New-JiraRemoteLinkIcon "https://somesite.com/icon.png" "my title"
            $obj.Keys | Should -Contain "url16x16"
        }
        It "returns an object with property 'title'" {
            $obj = New-JiraRemoteLinkIcon "https://somesite.com/icon.png" "my title"
            $obj.Keys | Should -Contain "title"
        }
        It "returns an object with property 'link' (when one is passed)" {
            $obj = New-JiraRemoteLinkIcon "https://somesite.com/icon.png" "my title" "https://somesite.com/tooltip.txt"
            $obj.Keys | Should -Contain "link"
        }
    }
    Context "properties set correctly" {
        It "returns an object with property 'url16x16' set to the value passed to -Url16x16" {
            $obj = New-JiraRemoteLinkIcon "https://somesite.com/icon.png" "my title"
            $obj.url16x16 | Should -Be "https://somesite.com/icon.png"
        }
        It "returns an object with property 'title' set to the value passed to -Title" {
            $obj = New-JiraRemoteLinkIcon "https://somesite.com/icon.png" "my title"
            $obj.title | Should -Be "my title"
        }
        It "returns an object with property 'link' set to the value (if any) passed to -ToolTipLink" {
            $obj = New-JiraRemoteLinkIcon "https://somesite.com/icon.png" "my title" "https://somesite.com/tooltip.txt"
            $obj.link | Should -Be "https://somesite.com/tooltip.txt"
        }
    }
}