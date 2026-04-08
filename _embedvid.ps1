$f = 'C:\The HUB Workspace\index.html'
$vf = 'C:\The HUB Workspace\bg.mp4'
$t = [System.IO.File]::ReadAllText($f)

# Base64 encode the video
$bytes = [System.IO.File]::ReadAllBytes($vf)
$b64 = [System.Convert]::ToBase64String($bytes)
Write-Output "Video base64 length: $($b64.Length) chars"

$dataUrl = "data:video/mp4;base64,$b64"

# Replace both video source references
$t = $t.Replace('<source src="bg.mp4" type="video/mp4">', '<source src="' + $dataUrl + '" type="video/mp4">')

# Verify
$count = ([regex]::Matches($t, 'data:video/mp4;base64,')).Count
Write-Output "Embedded video sources: $count"

[System.IO.File]::WriteAllText($f, $t)
Write-Output "Done. File size: $([Math]::Round($t.Length/1024,1)) KB"
