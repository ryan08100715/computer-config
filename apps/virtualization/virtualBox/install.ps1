#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\..\utils\utils.ps1

$PackageName = "VirtualBox"
$WingetPackageID = "Oracle.VirtualBox"

# * 安裝 VirtualBox
Write-Host "開始執行 $PackageName 安裝腳本" -ForegroundColor Green
Install-PackageByWinget $WingetPackageID
