#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\..\utils\output.ps1
. $PSScriptRoot\..\..\..\utils\winget.ps1
. $PSScriptRoot\..\..\..\utils\utils.ps1

$PackageName = "yt-dlp"
$WingetPackageID = "yt-dlp.yt-dlp"

Write-MyInfo "開始執行 $PackageName 安裝腳本..."

Update-EnvPath
Exit-WhenCommandNotExist -Command ffmpeg
Install-MyWinGetPackage -PackageName $PackageName -WingetPackageID $WingetPackageID

Write-MyInfo ""
