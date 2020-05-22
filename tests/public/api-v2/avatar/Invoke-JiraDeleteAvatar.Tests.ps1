# . $PSScriptRoot\..\..\..\mocks\MockRestMethod.ps1

# Describe "Invoke-JiraDeleteAvatar (Function)" {
#     Mock "New-Object" $MockRestMethod -ParameterFilter { $TypeName -and $TypeName -eq "RestMethod" } -ModuleName PowerJira

#     Context "Param Validation" {
#         It "only accepts 'issuetype' or 'project' for Type" {
#             { Invoke-JiraDeleteAvatar -Type "issuetype" -EntityId 1 -Id 1 } | Should -Not -Throw
#             { Invoke-JiraDeleteAvatar -Type "project" -EntityId 1 -Id 1 } | Should -Not -Throw
#             { Invoke-JiraDeleteAvatar -Type "faketype" -EntityId 1 -Id 1 } | Should -Throw
#         }
#     }
#     Context "Rest Arguments" {
#         $Type = "issuetype"
#         $entityId = 10000
#         $toDelete = 20000

#         It "passes the correct function path" {
#             $expected = "/rest/api/2/universal_avatar/type/$Type/owner/$entityId/avatar/$toDelete"

#             $result = Invoke-JiraDeleteAvatar -Type $Type -EntityId $entityId -Id $toDelete
#             $result.ArgumentList[0] | Should -Be $expected
#         }
#         It "passes the correct http verb" {
#             $expected = "DELETE"

#             $result = Invoke-JiraDeleteAvatar -Type $Type -EntityId $entityId -Id $toDelete
#             $result.ArgumentList[1] | Should -Be $expected
#         }
#     }
#     Context "Pipeline" {
#         $Type = "issuetype"
#         $entityId = 1
#         $toDeleteSingle = 2
#         $toDeleteMultiple = @(1,2,3)

#         It "pipes input correctly with one value" {
#             $expected = "/rest/api/2/universal_avatar/type/$Type/owner/$entityId/avatar/$toDeleteSingle"

#             $result = $toDeleteSingle | Invoke-JiraDeleteAvatar -Type $Type -EntityId $entityId
#             $result.ArgumentList[0] | Should -Be $expected
#         }
#         It "pipes input correctly with multiple values" {
#             $expected = @(
#                 "/rest/api/2/universal_avatar/type/$Type/owner/$entityId/avatar/" + [string]$toDeleteMultiple[0]
#                 "/rest/api/2/universal_avatar/type/$Type/owner/$entityId/avatar/" + [string]$toDeleteMultiple[1]
#                 "/rest/api/2/universal_avatar/type/$Type/owner/$entityId/avatar/" + [string]$toDeleteMultiple[2]
#             )

#             $results = $toDeleteMultiple | Invoke-JiraDeleteAvatar -Type $Type -EntityId $entityId
#             $results | ForEach-Object { $_.ArgumentList[0] } | Should -Be $expected
#         }
#     }
# }