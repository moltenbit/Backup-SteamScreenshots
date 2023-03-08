# Backup-SteamScreenshots
A script to backup your Steam screenshot folders.

<br/>

### Installation
```
PS C:\> Install-Module Backup-SteamScreenshots
```

### Usage
```
PS C:\> Import-Module Backup-SteamScreenshots
PS C:\> Backup-SteamScreenshots -DestinationPath C:\Your\Backup\Path
```

With Write-Information enabled:
```
PS C:\> Backup-SteamScreenshots -DestinationPath C:\Your\Backup\Path -InformationAction Continue
```

<br/>

### Example run

![backup](https://user-images.githubusercontent.com/31832259/223826237-4838d3b2-4355-48a8-8484-9372987d678a.png)


<br/>

Write-Information enabled

![backup-with-info](https://user-images.githubusercontent.com/31832259/223826320-8e3681a0-0d42-4772-8b9b-00fb1857e7c5.png)





