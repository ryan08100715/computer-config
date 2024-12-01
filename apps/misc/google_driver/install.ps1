#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\..\utils\utils.ps1

$PackageName = "GoogleDrive"
$WingetPackageID = "Google.GoogleDrive"

# * 安裝 GoogleDrive
Write-Host "開始執行 $PackageName 安裝腳本" -ForegroundColor Green
Install-PackageByWinget $WingetPackageID
