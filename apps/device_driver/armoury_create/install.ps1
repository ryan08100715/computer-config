#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\..\utils\utils.ps1

$PackageName = "Armoury Crate"
$WingetPackageID = "Asus.ArmouryCrate"

# * 安裝 Logitech G HUB
Write-Host "開始執行 $PackageName 安裝腳本" -ForegroundColor Green
Install-PackageByWinget $WingetPackageID $false
