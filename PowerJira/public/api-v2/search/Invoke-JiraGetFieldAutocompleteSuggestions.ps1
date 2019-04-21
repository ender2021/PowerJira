#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-jql-autocompletedata-suggestions-get
function Invoke-JiraGetFieldAutocompleteSuggestions {
    [CmdletBinding(DefaultParameterSetName="FieldValue")]
    param (
        # The name of the field to get suggestions for
        [Parameter(Mandatory,Position=0)]
        [string]
        $FieldName,

        # The partial field value to use to filter suggestions
        [Parameter(Position=1,ParameterSetName="FieldValue")]
        [string]
        $FieldValue,

        # The predicate name to get value suggestions for
        [Parameter(Mandatory,Position=1,ParameterSetName="PredicateValue")]
        [string]
        $PredicateName,

        # The partial predicate value to use to filter suggestions
        [Parameter(Position=2,ParameterSetName="PredicateValue")]
        [string]
        $PredicateValue,

        # The JiraConnection object to use for the request
        [Parameter(Position=2,ParameterSetName="FieldValue")]
        [Parameter(Position=3,ParameterSetName="PredicateValue")]
        [hashtable]
        $JiraConnection
    )
    process {
        $functionPath = "/rest/api/2/jql/autocompletedata/suggestions"
        $verb = "GET"

        $query=@{
            fieldName = $FieldName
        }
        if($PSBoundParameters.ContainsKey("FieldValue")){$query.Add("fieldValue",$FieldValue)}
        if($PSBoundParameters.ContainsKey("PredicateName")){$query.Add("predicateName",$PredicateName)}
        if($PSBoundParameters.ContainsKey("PredicateValue")){$query.Add("predicateValue",$PredicateValue)}

        Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Query $query
    }
}