$source = "c:\source"
$destination = "ftp://username:password@example.com/destination"

$webclient = New-Object -TypeName System.Net.WebClient

$files = Get-ChildItem $source

foreach ($file in $files)
{
    Write-Host "Uploading $file"
    $webclient.UploadFile("$destination/$file", $file.FullName)
} 

$webclient.Dispose()
