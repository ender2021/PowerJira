#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-universal-avatar-type-type-owner-entityId-post
function Invoke-JiraAddAvatar {
    [CmdletBinding()]
    param (
        # The type of avatar to load
        [Parameter(Mandatory,Position=0)]
        [ValidateSet("issuetype","project")]
        [string]
        $Type,

        # The id of the project or issue type to add an avatar to
        [Parameter(Mandatory,Position=1)]
        [string]
        $EntityId,

        # Avatar image file (use the output of a Get-Item call)
        [Parameter(Mandatory,Position=2,ValueFromPipeline)]
        [object]
        $Avatar,

        # The x position of the top left corner of the crop
        [Parameter(Position=3)]
        [int32]
        $CropX=0,

        # The y position of the top left corner of the crop
        [Parameter(Position=4)]
        [int32]
        $CropY=0,

        # The length of the crop sides
        [Parameter(Position=5)]
        [int32]
        $CropLength,

        # The JiraConnection object to use for the request
        [Parameter(Position=6)]
        [hashtable]
        $JiraConnection
    )
    begin {
        $results = @()
    }
    process {
        $functionPath = "/rest/api/2/universal_avatar/type/$Type/owner/$EntityId"
        $verb = "POST"

        try {
            $ImageType = $Avatar.Extension.Substring(1).ToUpper()
            if ($ImageType -eq "JPG") { $ImageType = "JPEG" }
            if (@("GIF","JPEG","PNG") -cnotcontains $ImageType) {throw "Invalid image type"}
        }
        catch {
            throw "Avatar File Error: Unable to load Avatar file.  Ensure that the file is of type .jpg, .jpeg, .png, or .gif"
        }

        $headers = @{
            "Content-Type" = "image/$ImageType"
        }

        $query = @{
            x = $CropX
            y = $CropY
        }
        if($PSBoundParameters.ContainsKey("CropLength")){$query.Add("size",$CropLength)}

        $file = $Avatar

        $results += Invoke-JiraRestMethod $JiraConnection $functionPath $verb -Headers $headers -Query $query -File $file
    }
    end {
        $results
    }
}