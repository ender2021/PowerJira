function Close-JiraSession() {
    process {
        $Global:PowerJira.CloseSession()
    }
}