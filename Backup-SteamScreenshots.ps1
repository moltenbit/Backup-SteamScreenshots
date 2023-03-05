$steamBasePath = Get-ItemPropertyValue -Path 'HKLM:\SOFTWARE\WOW6432Node\Valve\Steam\' -Name InstallPath
$getSteamDir = "$steamBasePath\userdata"
Write-Host -ForegroundColor Green "Using $getSteamDir as the Steam installation path."

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
