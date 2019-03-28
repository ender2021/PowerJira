$publicFiles = dir -Path $PSScriptRoot\public -Recurse -Include *.ps1 -ErrorAction SilentlyContinue

$publicFiles.BaseName