#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\..\utils\utils.ps1

$PackageName = "Steel Series GG"
$WingetPackageID = "SteelSeries.GG"

# * 安裝 Steel Series GG
Write-Host "開始執行 $PackageName 安裝腳本" -ForegroundColor Green
Install-PackageByWinget $WingetPackageID $false
