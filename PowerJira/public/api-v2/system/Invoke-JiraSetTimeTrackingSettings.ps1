#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-configuration-timetracking-options-put
function Invoke-JiraSetTimeTrackingSettings {
    [CmdletBinding()]
    param (
        # The number of hours in a working day.
        [Parameter(Mandatory,Position=0)]
        [double]
        $WorkingHoursPerDay,

        # The number of days in a working week.
        [Parameter(Mandatory,Position=1)]
        [double]
        $WorkingDaysPerWeek,

        # The format that will appear on an issue's Time Spent field.
        [Parameter(Mandatory,Position=2)]
        [ValidateSet("pretty", "days", "hours")]
        [string]
        $TimeFormat,

        # The default unit of time applied to logged time.
        [Parameter(Mandatory,Position=3)]
        [ValidateSet("minute", "hour", "day", "week")]
        [string]
        $DefaultUnit,

        # The JiraContext object to use for the request
        [Parameter()]
        [object]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/configuration/timetracking/options"
        $verb = "PUT"

        $body = New-PACRestMethodJsonBody @{
            workingHoursPerDay = $WorkingHoursPerDay
            workingDaysPerWeek = $WorkingDaysPerWeek
            timeFormat = $TimeFormat
            defaultUnit = $DefaultUnit
        }

        $method = New-PACRestMethod $functionPath $verb $null $body
        $method.Invoke($JiraContext)
    }
}