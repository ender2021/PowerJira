$JiraExpressionExpand = @("meta.complexity")

#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-expression-eval-post
function Invoke-JiraEvaluateExpression {
    [CmdletBinding()]
    param (
        # The expression to evaluate
        [Parameter(Mandatory,Position=0)]
        [string]
        $Expression,

        # The context to evaluate the expression within.  Use New-JiraExpressionContext
        [Parameter(Position=1)]
        [hashtable]
        $Context,

        # Used to expand additional attributes
        [Parameter(Position=2)]
        [ValidateScript({ Compare-StringArraySubset $JiraExpressionExpand $_ })]
        [string[]]
        $Expand,

        # The JiraContext object to use for the request
        [Parameter()]
        [object]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/expression/eval"
        $verb = "POST"

        $query = New-PACRestMethodQueryParams
        if($PSBoundParameters.ContainsKey("Expand")){$query.Add("expand",$Expand -join ",")}

        $body = New-PACRestMethodJsonBody @{
            expression = $Expression
        }
        if($PSBoundParameters.ContainsKey("Context")){$body.Add("context",$Context)}

        $method = New-PACRestMethod $functionPath $verb $query $body
        $method.Invoke($JiraContext)
    }
}