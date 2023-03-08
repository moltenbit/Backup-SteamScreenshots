<#
.Synopsis
   Backup script for copying your Steam screenshots.
.DESCRIPTION
   This script uses the Steam install path found in the registry to look for all folders in \userdata containing
   screenshot-folders and copies the images and folders to the destination path passed by the parameter.
.EXAMPLE
   PS C:\Temp> .\Backup-SteamScreenshots -DestinationPath C:\MyBackups

   Results in:

   		C:/
   		\- MyBackups/
   		\  \- Backup-SteamScreenshot-2023-03-06/
   		\  \  \- 123456-screenshots/
   		\  \  \  \- screenshot1.jpg
   		\  \  \  \- screenshot2.jpg
   		\  \  \- 234567-screenshots/
   		\  \  \  \- screenshot3.jpg
   		\  \  \- 345678-screenshots/
   		\  \  \  \- screenshot4.jpg
.Parameter DestinationPath
   [Mandatory!] Full destination path where the backup should be saved to.
.NOTES
   Author: sysadt
.LINK
   Author: https://github.com/sysadt
   Project: https://github.com/sysadt/Backup-SteamScreenshots
#>

function Backup-SteamScreenshots{
Param(
	[Parameter(Mandatory, HelpMessage = "A destination path is necessary.")] [String]$DestinationPath
)

$Date = Get-Date -format "yyyy-MM-dd"
$SteamInstallPath = Get-ItemPropertyValue -Path 'HKLM:\SOFTWARE\WOW6432Node\Valve\Steam\' -Name InstallPath
$SteamUserdataDir = "$($SteamInstallPath + '\userdata')"
$BackupPath = "$($DestinationPath + '\Backup-SteamScreenshots-' + $Date)"
$ScreenshotFolders = (Get-ChildItem -Path $SteamUserdataDir -Recurse -Directory | Where-Object {$_.Name -match "screenshot"}).FullName

Write-Information "> Starting Backup-SteamScreenshots.`n> Using $SteamUserdataDir as the Steam installation path."

if (-Not (Test-Path $BackupPath)) {
	foreach ($Path in $ScreenshotFolders) {

		$ParentDirName = (Get-Item $Path).Parent.Name

		try {
			Copy-Item -Path $Path -Destination $BackupPath\$Parentdirname-screenshots -Recurse
			Write-Information "> Copying $Path to $BackupPath\$Parentdirname-screenshots"
		} catch {
			Write-Error "> Error while trying to copy $Path."
		}
	}
} else {
	Write-Error "> A backup with the same name already exists in this location."
}

Write-Information "> Steam screenshot backup finished!"
}

Export-ModuleMember -Function Backup-SteamScreenshots
