function New-JiraPermissionGrant {
    [CmdletBinding()]
    param (
        # The holder of the permission.  Use New-JiraPermissionHolder
        [Parameter(Mandatory,Position=0)]
        [hashtable]
        $Holder,

        # The key of the permission to grant
        [Parameter(Mandatory,Position=1)]
        [string]
        $Permission
    )
    process {
        @{
            holder = $Holder
            permission = $Permission
        }
    }
}