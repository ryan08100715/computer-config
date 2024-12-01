#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\..\utils\utils.ps1

$PackageName = "JetBrains Toolbox"
$WingetPackageID = "JetBrains.Toolbox"

# * 安裝 JetBrains Toolbox
Write-Host "開始執行 $PackageName 安裝腳本" -ForegroundColor Green
Install-PackageByWinget $WingetPackageID $true
