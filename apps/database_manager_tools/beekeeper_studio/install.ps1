#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\..\utils\utils.ps1

$PackageName = "Beekeeper Studio"
$WingetPackageID = "beekeeper-studio.beekeeper-studio"

# * 安裝 Beekeeper Studio
Write-Host "開始執行 $PackageName 安裝腳本" -ForegroundColor Green
Install-PackageByWinget $WingetPackageID $false
