#!/usr/bin/env pwsh

. $PSScriptRoot\..\..\..\utils\utils.ps1

$PackageName = "VSCode"
$WingetPackageID = "Microsoft.VisualStudioCode"

# * 安裝 VSCode
Write-Host "開始執行 $PackageName 安裝腳本" -ForegroundColor Green
Install-PackageByWinget $WingetPackageID $true
