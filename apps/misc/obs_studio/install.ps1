#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\..\utils\utils.ps1

$PackageName = "OBS Studio"
$WingetPackageID = "OBSProject.OBSStudio"

# * 安裝 OBS Studio
Write-Host "開始執行 $PackageName 安裝腳本" -ForegroundColor Green
Install-PackageByWinget $WingetPackageID
