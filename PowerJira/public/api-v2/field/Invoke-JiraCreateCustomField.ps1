#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-field-post
function Invoke-JiraCreateCustomField {
    [CmdletBinding()]
    param (
        # The name of the field
        [Parameter(Mandatory,Position=0)]
        [string]
        $Name,

        # The type of the field
        [Parameter(Mandatory,Position=1)]
        [ValidateSet("cascadingselect","datepicker","datetime","float","grouppicker","importid",
                     "labels","multicheckboxes","multigrouppicker","multiselect","multiuserpicker",
                     "multiversion","project","radiobuttons","readonlyfield","select","textarea",
                     "textfield","url","userpicker","version")]
        [string]
        $Type,

        # The description of the field
        [Parameter(Position=2)]
        [string]
        $Description,

        # Set this flag to use a range type searcher when creating a "float" or "importid" field type
        [Parameter()]
        [switch]
        $Rangesearcher,

        # The JiraContext object to use for the request
        [Parameter()]
        [object]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/field"
        $verb = "POST"

        $searcherKey = switch ($Type) {
            "cascadingselect" { "cascadingselectsearcher" }
            "datepicker" { "daterange" }
            "datetime" { "datetimerange" }
            "float" { if($Rangesearcher) {"numberrange"} else {"exactnumber"} }
            "grouppicker" { "grouppickersearcher" }
            "importid" { if($Rangesearcher) {"numberrange"} else {"exactnumber"} } 
            "labels" { "labelsearcher" }
            "multicheckboxes" { "multiselectsearcher" }
            "multigrouppicker" { "multiselectsearcher" }
            "multiselect" { "multiselectsearcher" }
            "multiuserpicker" { "userpickergroupsearcher" } 
            "multiversion" { "versionsearcher" }
            "project" { "projectsearcher" }
            "radiobuttons" { "multiselectsearcher" }
            "readonlyfield" { "textsearcher" }
            "select" { "multiselectsearcher" }
            "textarea" { "textsearcher" } 
            "textfield" { "textsearcher" }
            "url" { "exacttextsearcher" }
            "userpicker" { "userpickergroupsearcher" }
            "version" { "versionsearcher" }
            Default {$null}
        }

        $body = New-PACRestMethodJsonBody @{
            name = $Name
            type = "com.atlassian.jira.plugin.system.customfieldtypes:$Type"
            searcherKey = "com.atlassian.jira.plugin.system.customfieldtypes:$searcherKey"
        }
        if($PSBoundParameters.ContainsKey("Description")){$body.Add("description",$Description)}

        $method = New-PACRestMethod $functionPath $verb $null $body
        $method.Invoke($JiraContext)
    }
}