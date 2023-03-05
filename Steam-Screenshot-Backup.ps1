Write-Host -ForegroundColor Green "Press Y if you use the default Steam installation path ( C:\Program Files (x86)\Steam\userdata ), otherwise paste your Steam userdata folder path:" 
$getSteamDir = Read-Host 

if ($getSteamDir -eq "y" -or $getSteamDir -eq "Y"){
	$steamDir = "C:\Program Files (x86)\Steam\userdata"
} else {
	$steamDir = $getSteamDir
}

$screenshotPaths = (Get-ChildItem -Path $steamDir -Recurse -Directory | Where-Object { $_.PSIsContainer -eq $true -and $_.Name -match "screenshot"}).FullName

Write-Host -ForegroundColor Green "Paste your backup path:"
$destinationPath = Read-Host

foreach ($path in $screenshotPaths){
	$parentDirName = (Get-Item "$path").parent.Name
	Write-Host -ForegroundColor Green "Copying $path to $destinationPath\$parentDirName-screenshots"
	Copy-Item -Path $path -Destination $destinationPath\$parentDirName-screenshots -recurse 
}

Write-Host -ForegroundColor Green "Steam screenshot backup finished!"
Write-Host -ForegroundColor Green "Press Enter to exit..."
Read-Host