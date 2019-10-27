#https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-project-projectIdOrKey-avatar2-post
function Invoke-JiraAddProjectAvatar {
    [CmdletBinding()]
    param (
        # The project Id or Key
        [Parameter(Mandatory,Position=0)]
        [string]
        $ProjectIdOrKey,

        # Avatar image file (use the output of a Get-Item call)
        [Parameter(Mandatory,Position=1)]
        [object]
        $Avatar,

        # The x position of the top left corner of the crop
        [Parameter(Position=2)]
        [int32]
        $CropX=0,

        # The y position of the top left corner of the crop
        [Parameter(Position=3)]
        [int32]
        $CropY=0,

        # The length of the crop sides
        [Parameter(Position=4)]
        [int32]
        $CropLength,

        # The JiraContext object to use for the request
        [Parameter()]
        [JiraContext]
        $JiraContext
    )
    process {
        $functionPath = "/rest/api/2/project/$ProjectIdOrKey/avatar2"
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

        $query = New-Object RestMethodQueryParams @{
            x = $CropX
            y = $CropY
        }
        if($PSBoundParameters.ContainsKey("CropLength")){$query.Add("size",$CropLength)}

        $file = $Avatar.VersionInfo.FileName

        $method = New-Object FileRestMethod @($functionPath,$verb,$query,$file)
        $method.Headers += $headers
        $method.Invoke($JiraContext)
    }
}