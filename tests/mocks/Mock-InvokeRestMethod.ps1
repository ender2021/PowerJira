$MockInvokeRestMethod = {
    @{
        Uri = $Uri
        Method = $Method
        ContentType = $ContentType
        Headers = $Headers
        Body = $Body
        Form = $Form
        InFile = $InFile
        MaximumRetryCount = $MaximumRetryCount
        RetryIntervalSec = $RetryIntervalSec
    }
}