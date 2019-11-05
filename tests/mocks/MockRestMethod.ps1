$MockRestMethod = {
    class MockRestMethod {
        [object[]]$ArgumentList
        [string]$TypeName
        [hashtable]$Headers

        MockRestMethod() {}

        [object]
        Invoke(
            [object]$JiraContext
        ){
            return $this
        }
    }

    $toReturn = [MockRestMethod]::new()
    $toReturn.ArgumentList = $ArgumentList
    $toReturn.TypeName = $TypeName
    return $toReturn
}