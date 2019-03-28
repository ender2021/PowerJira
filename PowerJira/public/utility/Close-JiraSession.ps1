function Close-JiraSession() {
    process {
        $Global:PowerJira.Session = $null
    }
}